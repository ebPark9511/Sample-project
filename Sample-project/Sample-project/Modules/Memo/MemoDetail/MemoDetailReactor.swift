//
//  MemoDetailReactor.swift
//  Sample-project
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
        case delete
    }
    
    enum Mutation {
        
    }
    
    struct State {
        let memo: Memo?
    }
    
    // MARK: - Steeper
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Properties
    var initialState: State
    let provider: ServiceProviderType
    
    deinit { print("\(type(of: self)): \(#function)") }
    
    init(
        initialState: State = .init(memo: nil),
        provider: ServiceProviderType
    ) {
        self.initialState = initialState
        self.provider = provider
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .delete:
            provider.memoryStorage.delete(memo: self.initialState.memo!)
            steps.accept(SampleStep.memoDetailIsComplete)
            return .empty()
        }
        
    }
}
