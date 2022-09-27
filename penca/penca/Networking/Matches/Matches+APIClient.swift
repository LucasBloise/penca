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

}
