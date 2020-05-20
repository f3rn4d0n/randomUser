//
//  UserListRouting.swift
//  randomUser
//
//  Created by Luis Fernando Bustos Ramírez on 18/05/20.
//  Copyright © 2020 justo. All rights reserved.
//

import UIKit

class UserListRouting: RoutingUserListProtocol {
    let view: UsersListViewController = UsersListViewController()
    let presenter = UsersListPresenter()
    let interactor = UsersListInteractor()
    var navigationController: UINavigationController?
    
    init() {
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.routing = self
        interactor.presenter = presenter
        navigationController = UINavigationController(rootViewController: view)
    }
    
    func seUserDetail(user:User){
        let routing = UserDetailRouting()
        routing.presenter.setUser(user: user)
        routing.view.modalPresentationStyle = .fullScreen
        view.navigationController?.pushViewController(routing.view, animated: true)
    }
}
