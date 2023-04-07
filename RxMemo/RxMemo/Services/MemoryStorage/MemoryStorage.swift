//
//  MemoryStorage.swift
//  RxMemo
//
//  Created by 박은비 on 2023/04/07.
//

import Foundation
import RxCocoa
import RxSwift

class MemoryStorage: MemoStorageType {
    
    private var list = [
        Memo(content: "Hello, RxSwift", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "Lorem, Ipsum", insertDate: Date().addingTimeInterval(-20)),
    ]
    
    private lazy var store = BehaviorSubject<[Memo]>(value: list)
    
    @discardableResult
    func createMemo(content: String) -> RxSwift.Observable<Memo> {
        let memo = Memo(content: content)
        list.insert(memo, at: 0)
        
        store.onNext(list)
        
        return .just(memo)
    }
    
    @discardableResult
    func memoList() -> RxSwift.Observable<[Memo]> {
        return store
    }
    
    @discardableResult
    func update(memo: Memo, content: String) -> RxSwift.Observable<Memo> {
        let updated = Memo(original: memo, updatedContent: content)
        
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        
        store.onNext(list)
        
        return .just(updated)
    }
    
    @discardableResult
    func delete(memo: Memo) -> RxSwift.Observable<Memo> {
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
        }
        
        store.onNext(list)
        
        return .just(memo)
    }
    
    
}
