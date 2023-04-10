//
//  MemoStorageType.swift
//  RxMemo
//
//  Created by 박은비 on 2023/04/07.
//

import Foundation

protocol MemoStorageType {
    
    @discardableResult
    func createMemo(content: String) -> Memo
    
    @discardableResult
    func memoList() -> [Memo]
    
    @discardableResult
    func update(memo: Memo, content: String) -> Memo
    
    @discardableResult
    func delete(memo: Memo) -> Memo
    
}
