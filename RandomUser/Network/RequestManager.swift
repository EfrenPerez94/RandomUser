//
//  RequestManager.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 23/03/21.
//

import Foundation
import UIKit

class RequestManager {
    
    // MARK: - USER PROFILE
    
    /// Create Request to fetch User
    /// - Returns: Request for User Model
    static func fetchUser() -> Request<User>? {
        guard let safeURL = URL(string: Constants.baseURL) else {
            return nil
        }
        
        var request = URLRequest(url: safeURL)
        request.httpMethod = HTTPMethod.get

        let currentRequest = Request<User>(request: request) { data -> User? in
            do {
                let jsonData = try JSONDecoder().decode(UserResults.self, from: data)
                return jsonData.results[0]
            } catch {
                return nil
            }
        }
        return currentRequest
    }

}
