//
//  ReqeustType.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/15.
//

import Foundation

protocol ReqeustType {
    var baseURL: String { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
}

extension ReqeustType {
    var urlComponents: URLComponents? { URLComponents(string: baseURL + path) }
    
    var request: URLRequest? {
        guard var urlComponents = self.urlComponents else {
            return nil
        }
        
        urlComponents.queryItems = self.queryItems
        
        var request = URLRequest(url: urlComponents.url!)
    
        request.allHTTPHeaderFields = self.headers
        request.httpMethod = self.method.rawValue
        
        switch self.method {
        case .post:
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        default:
            break
        }
        
        return request
    }
}
