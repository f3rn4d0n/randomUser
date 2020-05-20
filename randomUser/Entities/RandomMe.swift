//
//  RandomMe.swift
//  randomUser
//
//  Created by Luis Fernando Bustos Ramírez on 19/05/20.
//  Copyright © 2020 justo. All rights reserved.
//

import UIKit

struct RandomMe:Codable{
    var results: [User]
    var info: Info
}

struct Info:Codable{
    var seed: String
    var results: Int
    var page: Int
    var version: String
}
