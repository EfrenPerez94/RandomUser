//
//  UserModel.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 22/03/21.
//

import Foundation

/// User struct to store data retrieve from json.
struct User: Codable {
    let name: Name
    let location: Location
    let email: String
    let cell: String
    let picture: Picture
}
