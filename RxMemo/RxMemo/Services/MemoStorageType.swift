//
//  MemoStorageType.swift
//  RxMemo
//
//  Created by 박은비 on 2023/04/07.
//

import Foundation

import RxSwift

protocol MemoStorageType {
     
    var updated: BehaviorSubject<Void> { get set }
    
    @discardableResult
    func createMemo(content: String) -> Memo
    
    @discardableResult
    func memoList() -> [Memo]
    
    @discardableResult
    func update(memo: Memo, content: String) -> Memo
    
    @discardableResult
    func delete(memo: Memo) -> Memo
    
}
