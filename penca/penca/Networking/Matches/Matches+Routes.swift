//
//  Matches+Routes.swift
//  penca
//
//  Created by Lucas Bloise on 26/09/2022.
//

import Foundation

enum MatchesRoute: APIRoute {
    
    case bannersUrl
    var method: HTTPMethod { .get }
    var sessionPolicy: APIRouteSessionPolicy { .privateDomain }
    var path: String {
        switch self {
        case .bannersUrl: return "/files"
        }
    }
    var params: JSONDictionary { [:] }
}
