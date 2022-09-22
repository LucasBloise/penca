//
//  SessionManeger.swift
//  penca
//
//  Created by Lucas Bloise on 22/09/2022.
//

import Foundation

class SessionManager {
    static let shared = SessionManager()
    
    private var _sessionToken: String? {
        didSet { try? UserDefaultsManager.shared.set(object: _sessionToken, forKey: UserDefaultsManager.Keys.userSessionTokenKey) }
    }
    
    var sessionToken: String? { return _sessionToken }
    
    var isLoggedIn: Bool { return _sessionToken != nil }
    
    
    func setSessionToken(_ token: String?) {
      self._sessionToken = token
    }
}
