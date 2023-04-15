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
        case loadData
    }
    
    enum Mutation {
        case setRepos(_ repos: [Repository]?)
        case setError(_ message: String? = nil)
    }
    
    struct State {
        var keyword: String
        var repos: [Repository]?
        var errorMessage: String? = nil
    }
    
    // MARK: - Steeper
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Properties
    var initialState: State
    let provider: ServiceProviderType
    
    init(
        initialState: State,
        provider: ServiceProviderType
    ) {
        self.initialState = initialState
        self.provider = provider
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadData:
            return Observable.concat([
                self.provider.networkManger
                    .reqeust(GithubRequest.searchRepositories(q: self.initialState.keyword),
                             of: GithubSearchRepositories.self)
                    .asObservable()
                    .materialize() // RxSwift.Event<Int>로 바꾸어줌.
                    .map { event in
                        switch event {
                        case .next(let result):
                            return Mutation.setRepos(result.items)
                        case .error(let message):
                            return Mutation.setError(message.localizedDescription)
                        case .completed:
                            return Mutation.setError()
                            
                        }
                    }
                    
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setRepos(let repos):
            newState.repos = repos
            
        case .setError(let message):
            newState.errorMessage = message
        }
        return newState
    }
    
    
}
