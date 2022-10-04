//
//  MatchDetail.swift
//  penca
//
//  Created by Lucas Bloise on 04/10/2022.
//

import Foundation

struct MatchDetail: Codable {
    let matchId: Int
    let date, homeTeamName, homeTeamLogo: String
    let homeTeamGoals: Int
    let awayTeamName, awayTeamLogo: String
    let awayTeamGoals: Int
    let incidences: [Incidence]
    let predictionStatus, homeTeamPrediction, awayTeamPrediction: String?

}

struct Incidence: Codable {
    let minute: Int
    let side, event, playerName: String
}

