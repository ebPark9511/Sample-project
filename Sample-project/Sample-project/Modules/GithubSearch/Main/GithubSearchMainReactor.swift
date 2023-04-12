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
    }
    
    enum Mutation {
    }
    
    struct State {
    }
    
     
    // MARK: - Steeper
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Properties
    var initialState: State = .init()
//    let provider: ServiceProviderType
    
    
}
