//
//  MemoDetailReactor.swift
//  RxMemo
//
//  Created by 박은비 on 2023/04/07.
//

import Foundation

import RxCocoa
import RxFlow
import ReactorKit

class MemoDetailReactor: Reactor, Stepper {
    
    // MARK: - Events
    enum Action {
        
    }
    
    struct State {
        let memo: Memo?
        let contents: String?
    }
    
    // MARK: - Steeper
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Properties
    var initialState: State
    
    init(
        initialState: State = .init(memo: nil, contents: nil)
    ) {
        self.initialState = initialState
    }
}

//private func Date {
//    var formatter: DateFormatter {
//        let f = DateFormatter()
//        f.locale = Locale(identifier: "ko_kr")
//        f.dateStyle = .medium
//        f.timeStyle = .medium
//        return f
//    }
//}
// 메모보기 -> 편집 -> 메모편집 -> 메모보기에서 변경된 내용이 반영되어야 함.
