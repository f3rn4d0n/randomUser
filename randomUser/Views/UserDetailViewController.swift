//
//  UserDetailViewController.swift
//  randomUser
//
//  Created by Luis Fernando Bustos Ramírez on 19/05/20.
//  Copyright © 2020 justo. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher
import MessageUI

class UserDetailViewController: UIViewController {
    
    
    let backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "return"), for: .normal)
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return button
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9476025701, green: 0.1559439301, blue: 0.3836663365, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1842391789, green: 0.1748405397, blue: 0.2493930459, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userImg: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "whoIs")
        image.layer.cornerRadius = 75
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layoutIfNeeded()
        return image
    }()
    
    let phoneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "phone"), for: .normal)
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return button
    }()
    
    let emailButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "email"), for: .normal)
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.layer.cornerRadius = 20
        map.layer.masksToBounds = true
        return map
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(12)
        label.textColor = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var presenter: PresenterUserDetailProtocol?
    let heightImg:CGFloat = 150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.updateUI()
    }
    
    func setupUI(){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let guide = view.safeAreaLayoutGuide
        view.addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(mainView)
        mainView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        view.addSubview(userImg)
        userImg.centerXAnchor.constraint(equalToSystemSpacingAfter: headerView.centerXAnchor, multiplier: 1).isActive = true
        userImg.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -heightImg/2).isActive = true
        userImg.heightAnchor.constraint(equalToConstant: heightImg).isActive = true
        userImg.widthAnchor.constraint(equalToConstant: heightImg).isActive = true
        
        view.addSubview(phoneButton)
        phoneButton.centerYAnchor.constraint(equalTo: userImg.centerYAnchor).isActive = true
        phoneButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20).isActive = true
        phoneButton.trailingAnchor.constraint(equalTo: userImg.leadingAnchor, constant: -20).isActive = true
        phoneButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        phoneButton.addTarget(self, action: #selector(call), for: .touchUpInside)
        
        view.addSubview(emailButton)
        emailButton.centerYAnchor.constraint(equalTo: userImg.centerYAnchor).isActive = true
        emailButton.leadingAnchor.constraint(equalTo: userImg.trailingAnchor, constant: 20).isActive = true
        emailButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20).isActive = true
        emailButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailButton.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: userImg.bottomAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50).isActive = true
        mapView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 50).isActive = true
        mapView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -50).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(detailLabel)
        detailLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 50).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    }
    
    func updateUI(){
        if let user = presenter?.getUserInformation(){
            userImg.kf.setImage(
                with: URL(string: user.picture.large),
                placeholder: #imageLiteral(resourceName: "whoIs"),
                options: [.transition(.fade(3))]
            )
            nameLabel.text = "\(user.name.title). \(user.name.first) \(user.name.last)"
            if let latitud = Double(user.location.coordinates.latitude), let longitud = Double(user.location.coordinates.longitude){
                let userLocation = MKPointAnnotation()
                userLocation.title = "\(user.location.city)"
                userLocation.coordinate = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
                mapView.addAnnotation(userLocation)
                let region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                mapView.setRegion(region, animated: true)
            }
            detailLabel.text = """
            Some information about \(user.name.first):
            \(user.name.title) \(user.name.first) was introduced in this platform from: \(user.registered.date)
            Etc. etc. etc.
            """
        }
    }
    
    @objc func call(){
        if let user  = presenter?.getUserInformation(){
            guard let url = URL(string: "tel://\(user.cell)"), UIApplication.shared.canOpenURL(url) else {
                let alert = UIAlertController(title: "Error", message: "You can call \(user.name.first), try in a phisical devices or another person", preferredStyle: .alert)
                    let latter = UIAlertAction(title: "OK", style: .default) { (_) in}
                    alert.addAction(latter)
                    present(alert, animated: true, completion: nil)
                return
            }
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @objc func sendEmail(){
        if let user  = presenter?.getUserInformation(){
            if MFMailComposeViewController.canSendMail() {
                   let mail = MFMailComposeViewController()
                   mail.mailComposeDelegate = self
                mail.setToRecipients([user.email])
                   mail.setMessageBody("<p>Testing email</p>", isHTML: true)
                   present(mail, animated: true)
               } else {

                let alert = UIAlertController(title: "Error", message: "You can send a email to \(user.name.first), try in a phisical devices or another person", preferredStyle: .alert)
                let latter = UIAlertAction(title: "OK", style: .default) { (_) in}
                alert.addAction(latter)
                present(alert, animated: true, completion: nil)
                   // show failure alert
                
               }
        }
    }
    
    @objc func goBack(){
        presenter?.goBack()
    }
}

extension UserDetailViewController:ViewUserDetailProtocol{
   
}

extension UserDetailViewController: MFMailComposeViewControllerDelegate{
    
}
