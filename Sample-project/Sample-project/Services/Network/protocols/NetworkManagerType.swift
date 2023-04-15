//
//  NetworkManagerType.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/15.
//

import Foundation

import RxSwift

protocol NetworkManagerType {
    
    var session: URLSession { get set }
    func reqeust<T: ResponseType>(_ request: ReqeustType,
                                  of responseType: T.Type) -> Single<T>
    
    init(session: URLSession)
    
}
