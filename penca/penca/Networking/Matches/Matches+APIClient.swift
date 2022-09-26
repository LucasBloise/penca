//
//  Matches+ApiClient.swift
//  penca
//
//  Created by Lucas Bloise on 26/09/2022.
//

import Foundation

extension APIClient {
    func getBanners(onCompletion: @escaping (Result<Banners, APIError>) -> Void) {
        requestItem(MatchesRoute.bannersUrl) { (result: Result<Banners, APIError>) in
            switch result {
            case .success(let banners):
                onCompletion(.success(banners))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
        
    }
    

}
