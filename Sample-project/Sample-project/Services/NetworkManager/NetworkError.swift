//
//  NetworkError.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/15.
//

import Foundation

enum NetworkError: Error {
    case wrongRequest
    case invalidResponse
    case invalidData
}
