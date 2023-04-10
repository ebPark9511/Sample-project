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
        case delete
        case add
        case loadData
    }
     
    enum Mutation {
        case setMemos(_ memos: [Memo])
    }
    
    struct State {
        var memos: [Memo]?
    }
    
    // MARK: - Steeper
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Properties
    var initialState: State
    let provider: ServiceProviderType
    
    init(
        initialState: State = .init(),
        provider: ServiceProviderType
    ) {
        self.initialState = initialState
        self.provider = provider
    }
    
    // MARK: - mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .detail:
            steps.accept(SampleStep.memoDetail)
            return .empty()
            
        case .write:
            steps.accept(SampleStep.memoComposeIsRequired)
            return .empty()
            
        case .delete:
            return self.deleteMemo()
            
        case .add:
            return self.addMemo()
            
        case .loadData:
            return self.fetchMemo()
        }
    }
    
    // MARK: - reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setMemos(let memos):
            newState.memos = memos
        }
        
        return newState
    }
    
}

// MARK: Private Method
private extension MemoListReactor {
    
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
