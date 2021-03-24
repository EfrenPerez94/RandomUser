//
//  Request.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 23/03/21.
//

import Foundation

/// Structure needed to perform a request.
struct Request<T> {
    let request: URLRequest
    let parse: (Data) -> T?
}
