//
//  ServiceProvider.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/09.
//

import Foundation

protocol ServiceProviderType: AnyObject {
    var memoryStorage: MemoStorageType { get }
}

final class ServiceProvider: ServiceProviderType {
    var memoryStorage: MemoStorageType = MemoryStorage()
}
