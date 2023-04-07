//
//  MemoDetailReactor.swift
//  RxMemo
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
        
    }
    
    struct State {
        
    }
    
    // MARK: - Steeper
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Properties
    var initialState: State
    
    init(initialState: State) {
        self.initialState = initialState
    }
}
