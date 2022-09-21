//
//  APIClient.swift
//  penca
//
//  Created by Lucas Bloise on 21/09/2022.
//

import Foundation

final class APIClient {
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum SessionPolicy {
        case publicDomain, privateDomain
    }
    
    static let shared = APIClient()
    
    private init() { }
    
    private func request(_ route: APIRoute, onCompletion: @escaping (Result<Data, APIError>) -> Void) -> URLSessionDataTask? {
        do {
            let session = URLSession.shared.dataTask(with: try route.asURLRequest()) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        onCompletion(.failure(APIError(from: error)))
                    } else if let data = data {
                        onCompletion(.success(data))
                    } else {
                        onCompletion(.failure(.unknown))
                    }
                }
            }
            session.resume()
            return session
        } catch {
            onCompletion(.failure(APIError(from: error)))
            return nil
        }
    }
    
    @discardableResult func request(_ route: APIRoute, onCompletion: @escaping (Result<JSONDictionary, APIError>) -> Void) -> URLSessionDataTask? {
        request(route) { (result: Result<Data, APIError>) in
            switch result {
            case .success(let data):
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? JSONDictionary else {
                        onCompletion(.failure(.unknown))
                        return
                    }
                    onCompletion(.success(json))
                } catch {
                    onCompletion(.failure(APIError(from: error)))
                }
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
    @discardableResult func requestItem<T: Decodable>(_ route: APIRoute,
                                                      onCompletion: @escaping (Result<T, APIError>) -> Void) -> URLSessionDataTask? {
        request(route) { (result: Result<Data, APIError>) in
            switch result {
            case .success(let data):
                do {
                    onCompletion(.success(try JSONDecoder().decode(T.self, from: data)))
                } catch {
                    onCompletion(.failure(APIError(from: error)))
                }
            case .failure(let error): onCompletion(.failure(error))
            }
        }
    }
    
    // TODO: Add necessary checks
    private func checkResponse(_ response: HTTPURLResponse?) throws {
        guard let response = response else { throw APIError.noResponse }
        switch response.statusCode {
        case (200..<299): break
        case 401, 403:
            NotificationCenter.default.post(name: .authenticationError, object: nil, userInfo: nil)
            throw APIError.authenticationError
        case 418: throw APIError.teapot
        case (500..<599): throw APIError.serverError
        default: break
        }
    }
}

extension Notification.Name {
    static let authenticationError = Notification.Name("authenticationError")
}
