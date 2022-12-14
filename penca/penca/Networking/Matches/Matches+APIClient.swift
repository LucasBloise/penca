//
//  Matches+ApiClient.swift
//  penca
//
//  Created by Lucas Bloise on 26/09/2022.
//

import Foundation

extension APIClient {
    func getBanners(onCompletion: @escaping (Result<Banners, APIError>) -> Void) {
        requestItem(MatchesRoute.bannersUrl, onCompletion: onCompletion)
    }
    
    func getMatches(page: Int, pageSize: Int, teamName: String, status: String, order: String, onCompletion: @escaping (Result<Matches, APIError>) -> Void) {
        requestItem(MatchesRoute.matches(["page": page, "pageSize": pageSize, "teamName": teamName, "status": status, "order": order]),
                    onCompletion: onCompletion)
    }
    
    func getMatchDetail(matchId: Int,onCompletion: @escaping (Result<MatchDetail, APIError>) -> Void) {
        requestItem(MatchesRoute.matchDetail(matchId: matchId), onCompletion: onCompletion)
    }
    

}
