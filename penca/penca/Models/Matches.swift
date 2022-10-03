//
//  Matches.swift
//  penca
//
//  Created by Lucas Bloise on 26/09/2022.
//

import Foundation

struct Matches: Decodable {
    let matches: [Match]
    let pagination: Pagination
}

struct Match: Decodable {
    let matchId: Int
    let date: String
    let homeTeamId: Int
    let homeTeamName, homeTeamLogo: String
    let awayTeamId: Int
    let awayTeamName, awayTeamLogo, status: String
    let homeTeamGoals, awayTeamGoals: Int?
    var getMatchStatus: MatchStatus {
        return MatchStatus(rawValue: self.status)!
    }
    
}

struct Pagination: Decodable {
    let page, totalElements, totalPages, pageSize: Int
    let hasMorePages: Bool
}
enum MatchStatus: String {
  case pending, correct, incorrect
  case notPredicted = "not_predicted"
}
