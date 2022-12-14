//
//  Matches+Routes.swift
//  penca
//
//  Created by Lucas Bloise on 26/09/2022.
//

import Foundation

enum MatchesRoute: APIRoute {
    
    case bannersUrl
    case matches(JSONDictionary)
    case matchDetail(matchId: Int)
    var method: HTTPMethod { .get }
    var sessionPolicy: APIRouteSessionPolicy { .privateDomain }
    var path: String {
        switch self {
        case .bannersUrl: return "/files"
        case .matches: return "/match"
        case .matchDetail(let matchId): return "/match/\(matchId)"
        }
    }
    var params: JSONDictionary {
        switch self {
        case .bannersUrl: return [:]
        case .matches(let params): return params
        case .matchDetail: return [:]

    }
    }
   // var params: JSONDictionary { [:] }
}
