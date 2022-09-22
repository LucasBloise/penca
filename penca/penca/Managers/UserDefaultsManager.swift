//
//  UserDefaultsManager.swift
//  penca
//
//  Created by Lucas Bloise on 21/09/2022.
//

import Foundation

/// Exposes methods to interact with UserDefaultsManager
protocol UserDefaultsManagerProtocol {
    func set<T: Codable>(object: T, forKey key: UserDefaultsManager.Keys) throws
    func getObject<T: Codable>(forKey key: UserDefaultsManager.Keys, ofType type: T.Type) throws -> T
    func deleteObject(forKey key: UserDefaultsManager.Keys)
    func deleteAll()
}

public class UserDefaultsManager: UserDefaultsManagerProtocol {
    
    static let shared = UserDefaultsManager()
    
    private lazy var jsonEncoder = {
        JSONEncoder()
    }()
    
    private lazy var jsonDecoder = {
        return JSONDecoder()
    }()
    
    init() { }
    
    func set<T: Codable>(object: T, forKey key: Keys) throws {
        do {
            let objectToStore = try jsonEncoder.encode(object)
            UserDefaults.standard.setValue(objectToStore, forKey: key.keyString)
        } catch {
            throw DefaultsError.failedToEncode
        }
    }
    
    func getObject<T: Codable>(forKey key: Keys, ofType type: T.Type) throws -> T {
        let storedData = UserDefaults.standard.object(forKey: key.keyString) as? Data
        guard let data = storedData else { throw DefaultsError.noData }
        do {
            return try jsonDecoder.decode(type, from: data)
        } catch {
            throw DefaultsError.failedToDecode
        }
    }
    
    func deleteObject(forKey key: Keys) {
        UserDefaults.standard.removeObject(forKey: key.keyString)
    }
    
    func deleteAll() {
        Keys.allCases.forEach { deleteObject(forKey: $0) }
    }
}

extension UserDefaultsManager {
    enum Keys: CaseIterable {
        case userSessionTokenKey
        
        fileprivate var keyString: String { String(describing: self) }
    }
}

extension UserDefaultsManager {
    enum DefaultsError: Error {
        case failedToEncode
        case failedToDecode
        case noData
    }
}
