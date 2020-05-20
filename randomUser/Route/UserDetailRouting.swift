//
//  UserDetailRouting.swift
//  randomUser
//
//  Created by Luis Fernando Bustos Ramírez on 19/05/20.
//  Copyright © 2020 justo. All rights reserved.
//

import UIKit

class UserDetailRouting: RoutingUserDetailProtocol {
    let view: UserDetailViewController = UserDetailViewController()
    let presenter = UserDetailPresenter()
    let interactor = UserDetailInteractor()
    var navigationController: UINavigationController?
    
    init() {
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.routing = self
        interactor.presenter = presenter
    }
    
    func goBack(){
        view.navigationController?.popViewController(animated: true)
    }
}
