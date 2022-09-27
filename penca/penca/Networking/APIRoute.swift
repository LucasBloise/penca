//
//  APIRoute.swift
//  penca
//
//  Created by Lucas Bloise on 21/09/2022.
//

import Foundation

typealias JSONDictionary = [String: Any]

enum APIRouteSessionPolicy {
    case privateDomain, publicDomain
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
    case put = "PUT"
}

protocol APIRoute {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var sessionPolicy: APIRouteSessionPolicy { get }
    var apiVersion: String { get }
    
    var path: String { get }
    var params: JSONDictionary { get }
    
    func asURLRequest() throws -> URLRequest
}

extension APIRoute {
    var baseURL: String { "https://api.penca.inhouse.decemberlabs.com/api/v1" }
    var apiVersion: String { "" }
    var cachePolicy: URLRequest.CachePolicy { .reloadIgnoringLocalAndRemoteCacheData }
    
    func asURLRequest() throws -> URLRequest {
        let encodedPath = path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = baseURL + apiVersion + encodedPath
        let url: URL
        if [.get].contains(self.method) {
            var urlComponents = URLComponents(string: urlString)!
            urlComponents.queryItems = params.map { .init(name: $0.key, value: String(describing: $0.value)) }
            url = urlComponents.url!
        } else {
            url = URL(string: urlString)!
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.cachePolicy = self.cachePolicy
        
       if sessionPolicy == .privateDomain {
           guard let token = SessionManager.shared.sessionToken else { throw APIError.authenticationError }
           urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
       }
        
        if [.post, .put, .delete, .patch].contains(method) {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: self.params, options: [])
        }
        return urlRequest
    }
}
