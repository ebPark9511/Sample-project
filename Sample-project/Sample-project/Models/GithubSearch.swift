//
//  GithubSearch.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/15.
//

import Foundation

// MARK: - GithubSearchRepositories
struct GithubSearchRepositories: Decodable, ResponseType {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - Repository
struct Repository: Decodable, ResponseType {
    let id: Int
    let name: String?
    let owner: Owner?
    let description: String?
    let language: String?
    let stargazersCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case description
        case language
        case stargazersCount = "stargazers_count"
    }
}


// MARK: - Owner
struct Owner: Decodable, ResponseType {
    let login: String
    let avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}


// MARK: - Sort
enum GithubSearchSort: String, CaseIterable {
    case starts
    case forks
    case helpWantedIssues = "help-wanted-issues"
    case updated
}

// MARK: - Order
enum GithubSearchOrder: String, CaseIterable {
    case desc
    case asc
}


