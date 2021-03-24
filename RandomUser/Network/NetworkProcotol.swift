//
//  NetworkProcotol.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 23/03/21.
//

import Foundation

/// Typealias for clean naming
typealias GetResult<T> = Result<T, Error>
typealias GetCompletion<T> = (_ result: GetResult<T>) -> Void

/// Network generic protocol
protocol NetworkProtocol {
    static func fetchFromDB<T>(_ dbRequest: Request<T>?, completion: @escaping GetCompletion<T>)
    static func executeFromServer<T>(_ request: Request<T>?, completion: @escaping GetCompletion<T>)
}
