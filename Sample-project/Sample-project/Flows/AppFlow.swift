//
//  AppStep.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/09.
//
 
import UIKit

import RxSwift
import RxCocoa
import RxFlow

class AppStepper: Stepper {
    
    let steps: PublishRelay<Step> = .init()
    var initialStep: Step = SampleStep.memoList
    
    private let provider: ServiceProviderType
    private let disposeBag: DisposeBag = .init()
     
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
     
//    func readyToEmitSteps() {
//        provider.memoryStorage.memoList()
//            .map { $0.count }
//            .map { $0 > 0
//                ? SampleStep.memoList
//                : SampleStep.memoCompose
//            }
//            .bind(to: steps)
//            .disposed(by: disposeBag)
//    }
}

class AppFlow: Flow {
    
    var root: Presentable { self.rootWindow }

    private let rootWindow: UIWindow
    private let provider: ServiceProviderType
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    init(
        withWindow window: UIWindow,
        and services: ServiceProviderType
    ) {
        self.rootWindow = window
        self.provider = services
    }
    
    func navigate(to step: Step) -> FlowContributors {
//        guard let step = step as? SampleStep else { return FlowContributors.none }
        
        let memoFlow = MemoReadingFlow(with: self.provider)
        
        /// .created -> memoFlow의 root 파라메터를 클로저로 반환.
        Flows.use(memoFlow, when: .created) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        
        let nextStep = OneStepper(withSingleStep: step)
        
        return .one(flowContributor: .contribute(withNextPresentable: memoFlow,
                                                 withNextStepper: nextStep))
        
    }
    
}

