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
        case loadData
        case write
        case select(memo: Memo)
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
    
    deinit { print("\(type(of: self)): \(#function)") }
    
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
        case .loadData:
            return self.fetchMemo()
            
        case .write:
            steps.accept(SampleStep.memoComposeIsRequired)
            return .empty()
            
        case .select(let memo):
            steps.accept(SampleStep.memoDetail(memo))
            return .empty()
            
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
        return Observable.concat([
            self.provider.memoryStorage.memoList()
                .map { Mutation.setMemos($0) }
        ])
    }
     
//    func deleteMemo() -> Observable<Mutation> {
//        let list = self.provider.memoryStorage.memoList()
//
//        if let memo = list.first {
//            self.provider.memoryStorage.delete(memo: memo)
//        }
//
//        return Observable.concat([
//            self.provider.memoryStorage.memoList()
//                .map { Mutation.setMemos($0) }
//        ])
//    }
    
    func addMemo() -> Observable<Mutation> {
        self.provider.memoryStorage.createMemo(content: Date().description)
        return .empty()
        
    }
    
}
