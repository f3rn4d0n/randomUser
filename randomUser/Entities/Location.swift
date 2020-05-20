//
//  Location.swift
//  randomUser
//
//  Created by Luis Fernando Bustos Ramírez on 18/05/20.
//  Copyright © 2020 justo. All rights reserved.
//

import UIKit

struct Location:Codable{
    var street: Street
    var city: String
    var state: String
    var country: String
//    var postcode: Int?
    var coordinates: Coordinates
    var timezone: Timezone
}


struct Street:Codable{
    var number: Int
    var name:String
}

struct Coordinates:Codable{
    var latitude:String
    var longitude:String
}

struct Timezone:Codable{
    var offset:String
    var description:String
}
