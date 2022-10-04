//
//  MatchDetailViewController.swift
//  penca
//
//  Created by Lucas Bloise on 28/09/2022.
//

import Foundation
import UIKit

class MatchDetailViewController: UIViewController {
    
    var matchId: Int = 0
    
    override func viewDidLoad() {
        APIClient.shared.getMatchDetail(matchId: matchId) { apiResponse in
            switch apiResponse {
            case .success(let matchDetailResponse):
                print(matchDetailResponse)
            case .failure(let error):
                print(error)
            }
        }
        super.viewDidLoad()
    }

}

