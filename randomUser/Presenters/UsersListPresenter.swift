//
//  UsersListPresenter.swift
//  randomUser
//
//  Created by Luis Fernando Bustos Ramírez on 18/05/20.
//  Copyright © 2020 justo. All rights reserved.
//

import UIKit

class UsersListPresenter: PresenterUserListProtocol {
    var view:ViewUserListProtocol?
    var interactor:InteractorUserListProtocolInput?
    var routing:RoutingUserListProtocol?
    
    var users:[User] = []
    var filtredUsers:[User] = []
    
    func selectUser(user: User) {
        routing?.seUserDetail(user: user)
    }
    
    func reloadUsers() {
        interactor?.requestListUsers()
    }
    
    func getListUsers(users: [User]) {
        self.users = users
    }
    
    func countListUsers() -> Int {
        return filtredUsers.count
    }
    
    func getUserAt(index: Int) -> User? {
        return filtredUsers[index]
    }
    
    func searchUsers(name: String, gender: String) {
        filtredUsers = users.filter({ (user:User) -> Bool in
            let genderMatch = (gender == "All") || (user.gender.uppercased() == gender.uppercased())
            if name.count == 0{
                return genderMatch
            }else{
                return genderMatch && (
                    user.name.first.uppercased().contains(name.uppercased()) || user.name.last.uppercased().contains(name.uppercased())
                )
            }
        })
        view?.showListUsers()
    }
    
}

extension UsersListPresenter: InteractorUserListProtocolOutput{
    func errorServices(message: String) {
        view?.showErrorDetail(error: message)
    }
    
    func newListOfUsers(users: [User]) {
        self.users = users
        self.filtredUsers = users
        view?.showListUsers()
    }
    
    func requestError(_ error: Error) {
        view?.showErrorDetail(error: error.localizedDescription)
    }
}
