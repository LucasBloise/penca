//
//  SessionManeger.swift
//  penca
//
//  Created by Lucas Bloise on 22/09/2022.
//

import Foundation

class SessionManager {
    static let shared = SessionManager()
    private(set) var sessionToken: String? {
        get {
            try? UserDefaultsManager.shared.getObject(forKey: UserDefaultsManager.Keys.userSessionTokenKey, ofType: String.self)
        }
        set {
            try? UserDefaultsManager.shared.set(object: newValue, forKey: UserDefaultsManager.Keys.userSessionTokenKey)
        }
    }
    
    func setSessionToken(_ sessionToken: String) {
        self.sessionToken = sessionToken
    }
    
    var isLoggedIn: Bool { return sessionToken != nil }
    
    
    
}
