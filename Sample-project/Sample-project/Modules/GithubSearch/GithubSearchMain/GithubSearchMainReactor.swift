//
//  GithubSearchMainReactor.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/12.
//

import Foundation

import RxCocoa
import ReactorKit
import RxFlow

class GithubSearchMainReactor: Reactor, Stepper {
    
    // MARK: - Events
    enum Action {
        case click(_ text: String)
    }
    
    enum Mutation {
    }
    
    struct State {
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
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .click(let text):
            steps.accept(SampleStep.githubSearchList(text) )
        }
        return .empty()
    }
    
    
}
