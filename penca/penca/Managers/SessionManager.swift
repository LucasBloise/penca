//
//  SessionManeger.swift
//  penca
//
//  Created by Lucas Bloise on 22/09/2022.
//

import Foundation

class SessionManager {
    static let shared = SessionManager()
    
    var isLoggedIn: Bool { return getSessionToken() != nil }
    
    func setSessionToken(_ token: String?) {
        try? UserDefaultsManager.shared.set(object: token, forKey: UserDefaultsManager.Keys.userSessionTokenKey)
    }
    
    func getSessionToken() -> String? {
        try? UserDefaultsManager.shared.getObject(forKey: UserDefaultsManager.Keys.userSessionTokenKey, ofType: String.self)
    }
    
    
}
