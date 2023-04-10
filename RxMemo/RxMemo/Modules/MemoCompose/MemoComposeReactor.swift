//
//  MemoComposeReactor.swift
//  RxMemo
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
        case save
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
            
        case .save:
            steps.accept(SampleStep.memoComposeIsComplete)
        }
        
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        return newState
    }
}

// MARK: Private Method
private extension MemoComposeReactor {
    
    func fetchMemo() -> Observable<Mutation> {
        return .just(.setMemos(self.provider.memoryStorage.memoList()))
    }
     
    func deleteMemo() -> Observable<Mutation> {
        let list = self.provider.memoryStorage.memoList()
        
        if let memo = list.first {
            self.provider.memoryStorage.delete(memo: memo)
        }
        
        return .just(.setMemos(self.provider.memoryStorage.memoList()))
    }
    
    func addMemo() -> Observable<Mutation> {
        self.provider.memoryStorage.createMemo(content: Date().description)
        
        return .just(.setMemos(self.provider.memoryStorage.memoList()))
        
    }
    
}
