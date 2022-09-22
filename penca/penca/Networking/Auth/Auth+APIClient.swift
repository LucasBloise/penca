//
//  Auth+APIClient.swift
//  penca
//
//  Created by Lucas Bloise on 22/09/2022.
//

import Foundation

extension APIClient {
    func postSignUp(userEmail: String, userPassword: String, onCompletion: @escaping (Result<User, APIError>) -> Void) {
        requestItem(AuthRoute.signUp(["email": userEmail, "password": userPassword])) { (result: Result<User, APIError>) in
            switch result {
            case .success(let user):
                onCompletion(.success(user))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
    func postLogIn(userEmail: String, userPassword: String, onCompletion: @escaping (Result<User, APIError>) -> Void) {
        requestItem(AuthRoute.logIn(["email": userEmail, "password": userPassword])) { (result: Result<User, APIError>) in
            switch result {
            case .success(let user):
                onCompletion(.success(user))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}
