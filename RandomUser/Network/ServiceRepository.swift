//
//  ServiceRepository.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 23/03/21.
//

import UIKit

class ServiceRepository: NetworkProtocol {
    
    /**
     Perform a generic request into DB, handling errors and response.
     
     - Parameters:
        - request: DBRequest ready for execute.
        - completion: Closure that returns a `result` for the DB request.
        - result: Provide an error or success to the user.
     */
    static func fetchFromDB<T>(_ dbRequest: Request<T>?, completion: @escaping GetCompletion<T>) {
        executeFromServer(dbRequest, completion: completion)
    }
    
    /**
     Perform a generic request, handling errors and response.
     
     - Parameters:
        - request: URLRequest ready for execute.
        - completion: Closure that returns a `result` for the network request.
        - result: Provide an error or success to the user.
     */
    static func executeFromServer<T>(_ request: Request<T>?, completion: @escaping GetCompletion<T>) {
        
        guard let safeRequest = request else {
            DispatchQueue.main.async {
                completion(.failure(RepositoryError.badRequest))
            }
            return
        }
        
        URLSession.shared.dataTask(with: safeRequest.request) { (data, response, error) in
            // Store auth token if exists
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if let responseError = self.getNetworkError(from: httpResponse) {
                    DispatchQueue.main.async {
                        completion(.failure(responseError))
                    }
                    return
                }
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(RepositoryError.dataIsNil))
                }
                return
            }
            
            if let object = safeRequest.parse(data) {
                DispatchQueue.main.async {
                    completion(.success(object))
                }
                return
            } else {
                DispatchQueue.main.async {
                    completion(.failure(RepositoryError.failedParsing))
                }
                return
            }
        }.resume()
    }
    
    /**
     Retrieve a custom error for an specific HTTP response.
     
     - Parameters:
        - response: `HTTPURLResponse` to get the status code.
     - Returns: A custom error description.
     */
    private static func getNetworkError(from response: HTTPURLResponse) -> RepositoryError? {
        switch response.statusCode {
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 408:
            return .requestTimeout
        case 429:
            return .tooManyRequest
        case 500:
            return .internalServerError
        default:
            return nil
        }
    }
}
