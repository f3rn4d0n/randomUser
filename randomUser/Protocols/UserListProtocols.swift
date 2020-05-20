//
//  UserListProtocols.swift
//  randomUser
//
//  Created by Luis Fernando Bustos Ramírez on 18/05/20.
//  Copyright © 2020 justo. All rights reserved.
//

protocol ViewUserListProtocol{
    func showErrorDetail(error:String)
    func showListUsers()
}
protocol PresenterUserListProtocol{
    func selectUser(user:User)
    func reloadUsers()
    func getListUsers(users:[User])
    func countListUsers() -> Int
    func getUserAt(index:Int) -> User?
    func searchUsers(name:String, gender:String)
}
protocol InteractorUserListProtocolInput{
    func requestListUsers()
}
protocol InteractorUserListProtocolOutput{
    func errorServices(message:String)
    func newListOfUsers(users: [User])
    func requestError(_ error:Error)
}
protocol RoutingUserListProtocol{
    func seUserDetail(user:User)
}
