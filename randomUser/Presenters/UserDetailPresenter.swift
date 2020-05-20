//
//  UserDetailPresenter.swift
//  randomUser
//
//  Created by Luis Fernando Bustos Ramírez on 19/05/20.
//  Copyright © 2020 justo. All rights reserved.
//

import UIKit

class UserDetailPresenter: PresenterUserDetailProtocol {
    
    var view:ViewUserDetailProtocol?
    var interactor:InteractorUserDetailProtocolInput?
    var routing:RoutingUserDetailProtocol?
    
    var user: User!
    
    func setUser(user: User) {
        self.user = user
    }
    
    func getUserInformation() -> User {
        return user
    }
    
    func goBack() {
        routing?.goBack()
    }
}

extension UserDetailPresenter: InteractorUserDetailProtocolOutput{
   
}
