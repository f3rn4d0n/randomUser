//
//  UserDetailProtocols.swift
//  randomUser
//
//  Created by Luis Fernando Bustos Ramírez on 19/05/20.
//  Copyright © 2020 justo. All rights reserved.
//

import UIKit

protocol ViewUserDetailProtocol{
}

protocol PresenterUserDetailProtocol{
    func setUser(user:User)
    func getUserInformation() -> User
    func goBack()
}
protocol InteractorUserDetailProtocolInput{
}

protocol InteractorUserDetailProtocolOutput{
}

protocol RoutingUserDetailProtocol{
    func goBack()
}



