//
//  MemoListReactor.swift
//  RxMemo
//
//  Created by 박은비 on 2023/04/07.
//

import Foundation

import RxCocoa
import ReactorKit
import RxFlow

/// Stepper 특정 탐색 상태에 해당하는 단계를 내보냅니다.
/// 단계 변경은 특정 Flow의 문맥에서 탐색 작업으로 이어집니다.
class MemoListReactor: Reactor, Stepper {
    
    // MARK: - Events
    enum Action {
        case detail
        case write
    }
    
    struct State {
        
    }
    
    // MARK: - Steeper
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Properties
    var initialState: State
    
    init(initialState: State) {
        self.initialState = initialState
    }
    
    func mutate(action: Action) -> Observable<Action> {
        switch action {
        case .detail:
            steps.accept(SampleStep.memoDetail)
            return .empty()
            
        case .write:
            steps.accept(SampleStep.memoComposeIsRequired)
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Action) -> State {
        var newState = state
        
        
        return newState
    }
    
}
