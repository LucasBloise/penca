//
//  Matches.swift
//  penca
//
//  Created by Lucas Bloise on 26/09/2022.
//

import Foundation

struct Matches: Codable {
    let matches: [Match]
    let pagination: Pagination
}

struct Match: Codable {
    let matchId: Int
    let date: String
    let homeTeamId: Int
    let homeTeamName, homeTeamLogo: String
    let awayTeamId: Int
    let awayTeamName, awayTeamLogo, status: String
    let homeTeamGoals, awayTeamGoals: Int

}

struct Pagination: Codable {
    let page, totalElements, totalPages, pageSize: Int
    let hasMorePages: Bool
}
