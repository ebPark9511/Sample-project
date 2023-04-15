//
//  GithubSearchResultReactor.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/15.
//

import Foundation

import RxCocoa
import ReactorKit
import RxFlow

class GithubSearchResultReactor: Reactor, Stepper {
    
    // MARK: - Events
    enum Action {
    }
    
    enum Mutation {
    }
    
    struct State {
        let searchKeyword: String
    }
    
     
    // MARK: - Steeper
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Properties
    var initialState: State
//    let provider: ServiceProviderType
    
    init(initialState: State) {
        self.initialState = initialState
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    
}
