//
//  MemoComposeReactor.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/07.
//

import Foundation

import RxCocoa
import RxFlow
import ReactorKit

class MemoComposeReactor: Reactor, Stepper {
    
    // MARK: - Events
    enum Action {
        case save(content: String)
        case cancel
    }
    
   enum Mutation {
       case setMemos(_ memos: [Memo])
   }
    
    struct State {
        let content: String?
    }
    
    // MARK: - Steeper
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Properties
    var initialState: State
    let provider: ServiceProviderType
    
    deinit { print("\(type(of: self)): \(#function)") } 
    
    init(
        initialState: State = .init(content: nil),
        provider: ServiceProviderType
    ) {
        self.initialState = initialState
        self.provider = provider
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .cancel:
            steps.accept(SampleStep.memoComposeIsComplete)
            
        case .save(let content):
            provider.memoryStorage.createMemo(content: content)
            steps.accept(SampleStep.memoComposeIsComplete)
        }
        
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
//        var newState = state
        return state
    }
}

// MARK: Private Method
private extension MemoComposeReactor {
    
}
