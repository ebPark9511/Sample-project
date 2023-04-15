//
//  ServiceProvider.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/09.
//

import Foundation

protocol ServiceProviderType: AnyObject {
    var memoryStorage: MemoStorageType { get }
    var networkManger: NetworkManagerType { get }
}

final class ServiceProvider: ServiceProviderType {
    let session: URLSession
    
    var memoryStorage: MemoStorageType = MemoryStorage()
    lazy var networkManger: NetworkManagerType = NetworkManger(session: self.session)

    init(session: URLSession = .shared) {
        self.session = session
    }
}
