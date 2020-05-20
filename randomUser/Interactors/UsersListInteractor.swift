//
//  UsersListInteractor.swift
//  randomUser
//
//  Created by Luis Fernando Bustos Ramírez on 18/05/20.
//  Copyright © 2020 justo. All rights reserved.
//

import UIKit
import Network

class UsersListInteractor: InteractorUserListProtocolInput {
    
    var presenter: InteractorUserListProtocolOutput?
    var dataTask: URLSessionDataTask?
    let monitor = NWPathMonitor()
    var internetEnable = true
    
    func requestListUsers() {
        self.checkInternetConnection()
        if !internetEnable{
            self.presenter?.errorServices(message: "Internet connection is not enable, please try again latter" )
            return
        }
        
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: "https://randomuser.me/api") {
          urlComponents.query = "results=\(20)"
          guard let url = urlComponents.url else {
            return
          }
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15.0
        sessionConfig.timeoutIntervalForResource = 15.0
        let session = URLSession(configuration: sessionConfig)
          dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            defer {
              self?.dataTask = nil
            }
            DispatchQueue.main.async {
                if let error = error {
                    self?.presenter?.requestError(error)
                } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    do{
                        let random = try JSONDecoder().decode(RandomMe.self, from: data)
                        self?.presenter?.newListOfUsers(users: random.results)
                    } catch let error{
                        self?.presenter?.requestError(error)
                    }
                }
            }
          }
          dataTask?.resume()
        }
    }
    
    func checkInternetConnection(){
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
            } else {
                print("No connection.")
            }
            print(path.isExpensive)
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
