//
//  Auth+Routes.swift
//  penca
//
//  Created by Lucas Bloise on 22/09/2022.
//

import Foundation

enum AuthRoute: APIRoute {
    
    case signUp(JSONDictionary)
    case logIn(JSONDictionary)
    var method: HTTPMethod { .post }
    var sessionPolicy: APIRouteSessionPolicy { .publicDomain }
    var path: String {
        switch self {
        case .signUp: return "/user"
        case .logIn: return "/user/login"
        }
    }
    var params: JSONDictionary {
        switch self {
        case .signUp(let params): return params
        case .logIn(let params): return params
        }
    }
}
