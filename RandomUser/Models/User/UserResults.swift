//
//  UserResults.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 23/03/21.
//

import Foundation

/// Data struct to store data retrieve from json.
struct UserResults: Codable {
    let results: [User]
}
