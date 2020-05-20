//
//  UsersListViewController.swift
//  randomUser
//
//  Created by Luis Fernando Bustos Ramírez on 18/05/20.
//  Copyright © 2020 justo. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class UsersListViewController: UIViewController, NVActivityIndicatorViewable {
    
    lazy var userListTableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 5
        tableView.layer.masksToBounds = true
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserListTableViewCell.self, forCellReuseIdentifier: "UserListTableViewCellIdentifier")
        return tableView
    }()
    
    lazy var searchBar:UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.searchBarStyle = .minimal
        search.searchBar.placeholder = " Search persons with name"
        search.searchBar.sizeToFit()
        search.searchBar.isTranslucent = true
        search.searchBar.scopeButtonTitles = ["All", "Male", "Female"]
        search.searchBar.delegate = self
        search.searchResultsUpdater = self
        return search
    }()
    
    var presenter: PresenterUserListProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1842222512, green: 0.1747326553, blue: 0.2534305155, alpha: 1)
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if presenter?.countListUsers() ?? 0 <= 0{
            reloadUsersData()
        }
    }
    
    func setupNavigationBar(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backgroundColor =  #colorLiteral(red: 0.9476025701, green: 0.1559439301, blue: 0.3836663365, alpha: 1)
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let segmentBarItem = UIBarButtonItem(title: "Reload", style: .done, target: self, action: #selector(reloadUsersData))
        navigationItem.rightBarButtonItem = segmentBarItem
        navigationItem.title = "List of users"
        navigationItem.searchController = searchBar
    }
    
    func setupTableView(){
        let guide = view.safeAreaLayoutGuide
        view.addSubview(userListTableView)
        userListTableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        userListTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        userListTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        userListTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    }
    
    @objc func reloadUsersData(){
        startAnimating(CGSize.init(width: 50, height: 50),
                       message: "Wait a moment please",
                       messageFont: UIFont.boldSystemFont(ofSize: 12),
                       type: .ballRotate,
                       color: .white,
                       padding: 0.0,
                       displayTimeThreshold: 10,
                       minimumDisplayTime: 2,
                       backgroundColor: #colorLiteral(red: 0.1842391789, green: 0.1748405397, blue: 0.2493930459, alpha: 1),
                       textColor: .white)
        self.presenter?.reloadUsers()
    }
}

extension UsersListViewController:ViewUserListProtocol{
    func showErrorDetail(error: String) {
        self.stopAnimating()
        print(error)
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let again = UIAlertAction(title: "Try again", style: .default) { (_) in
            self.reloadUsersData()
        }
        alert.addAction(again)
        let latter = UIAlertAction(title: "More latter", style: .default) { (_) in}
        alert.addAction(latter)
        present(alert, animated: true, completion: nil)
    }
    
    func showListUsers(){
        self.stopAnimating()
        userListTableView.reloadData()
    }
}

extension UsersListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.countListUsers() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCellIdentifier", for: indexPath) as! UserListTableViewCell
        cell.setupUI()
        if let user = presenter?.getUserAt(index: indexPath.row){
            cell.fillWithUser(user: user)
        }else{
            cell.fillWithError()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let user = presenter?.getUserAt(index: indexPath.row){
            searchBar.resignFirstResponder()
            presenter?.selectUser(user: user)
        }
    }
}

extension UsersListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        presenter?.searchUsers(name: searchBar.text ?? "", gender: searchBar.scopeButtonTitles![selectedScope])
    }
}
 
extension UsersListViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let gender = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        presenter?.searchUsers(name: searchBar.text ?? "", gender: gender)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.searchUsers(name: "", gender: "All")
    }
}
