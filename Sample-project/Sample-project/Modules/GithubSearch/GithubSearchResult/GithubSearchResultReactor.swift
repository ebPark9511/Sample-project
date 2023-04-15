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
        case loadNextPage
    }
    
    enum Mutation {
        case setRepos([Repository], nextPage: Int?)
        case appendRepos([Repository], nextPage: Int?)
        case setLoadingNextPage(Bool)
        case setError(Bool)
    }
    
    struct State {
        var query: String
        var repos: [Repository] = []
        var nextPage: Int?
        var isLoadingNextPage: Bool = false
        var isNetworkError: Bool = false
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
            Observable.just(Mutation.setLoadingNextPage(true)),
            self.search(query: self.initialState.query, page: 0),
            Observable.just(Mutation.setLoadingNextPage(false)),
          ])

        
        default:
            return Observable.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setRepos (let repos, let nextPage):
          newState.repos = repos
          newState.nextPage = nextPage
          return newState
//
//        case let .appendRepos(repos, nextPage):
//          newState.repos.append(contentsOf: repos)
//          newState.nextPage = nextPage
//          return newState
//
        case .setLoadingNextPage(let isLoadingNextPage):
          newState.isLoadingNextPage = isLoadingNextPage
          return newState
            
            
        case .setError(let isError):
            newState.isNetworkError = isError
            
        default:
            break
        }
        return newState
    }
}

private extension GithubSearchResultReactor {
    
    func search(query: String, page: Int) -> Observable<Mutation> {
        
        return self.provider.networkManger
            .reqeust(GithubRequest.searchRepositories(q: query),
                     of: GithubSearchRepositories.self)
            .delay(.seconds(10), scheduler: MainScheduler.instance)
            .asObservable()
            .materialize() // RxSwift.Event<Int>로 바꾸어줌.
            .compactMap { event in
                switch event {
                case .next(let result):
                    return Mutation.setRepos(result.items ?? [], nextPage: page)
                case .error:
                    return Mutation.setError(true)
                case .completed:
                    return nil
                }
                
            }
        
    }
    
}
