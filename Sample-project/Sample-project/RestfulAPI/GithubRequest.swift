//
//  GithubRequest.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/15.
//

import Foundation

enum GithubRequest {
    // https://docs.github.com/ko/rest/search?apiVersion=2022-11-28#search-repositories
    case searchRepositories(
        q: String,
        sort: GithubSearchSort? = nil, // stars, forks, help-wanted-issues, updated
        order: GithubSearchOrder = .desc, // desc, asc
        perPage: Int = 30,
        page: Int = 1
    )
}

extension GithubRequest: ReqeustType {
    var baseURL: String {
        "https://api.github.com"
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchRepositories:
            return .get
        }
    }
     
    var path: String {
        switch self {
        case .searchRepositories:
            return "/search/repositories"
        }
    }
    
    var headers: [String : String]? {
    
        var dict = [String: String]()
        
        dict["Authorization"] = "Bearer {TOKEN}"
        
        switch self {
        case .searchRepositories:
            break
        }
        
        return dict
    }
    
    var queryItems: [URLQueryItem]? {
        
        var queryItems: [URLQueryItem] = []
        
        switch self {
        case .searchRepositories(let q,
                                 let sort,
                                 let order,
                                 let perPage,
                                 let page):
        
            queryItems.append(contentsOf: [
                URLQueryItem(name: "q", value: q),
                URLQueryItem(name: "sort", value: sort?.rawValue ?? ""),
                URLQueryItem(name: "order", value: order.rawValue),
                URLQueryItem(name: "per_page", value: String(perPage)),
                URLQueryItem(name: "page", value: String(page))
            ])
             
        }
        
        return queryItems
    }
}
