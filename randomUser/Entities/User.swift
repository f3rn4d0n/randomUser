//
//  User.swift
//  randomUser
//
//  Created by Luis Fernando Bustos Ramírez on 18/05/20.
//  Copyright © 2020 justo. All rights reserved.
//

import UIKit

struct User: Codable {
    var gender:String
    var name: Name
    var location:Location
    var email: String
    var login:Login
    var dob:Dob
    var registered:Registered
    var phone:String
    var cell:String
    var id:Id
    var picture:Picture
    var cat:String?
}

struct Name: Codable{
    var title:String
    var first:String
    var last:String
}

struct Login:Codable{
    var uuid: String
    var username: String
    var password: String
    var salt: String
    var md5: String
    var sha1: String
    var sha256: String
}

struct Dob:Codable{
    var date:String
    var age:Int?
}

struct Registered:Codable{
    var date:String
    var age:Int?
}

struct Id:Codable{
    var name:String
    var value:String?
}

struct Picture:Codable{
    var large:String
    var medium:String
    var thumbnail:String
}


