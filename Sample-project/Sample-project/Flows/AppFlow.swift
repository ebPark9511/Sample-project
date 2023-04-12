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
    var initialStep: Step = SampleStep.dashboardIsRequired
    
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
    
    private let rootViewController = UINavigationController()

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
        guard let step = step as? SampleStep else { return FlowContributors.none }
        
        switch step {
        case .dashboardIsRequired:
            return self.coordinatorToDashboard()
        default:
            return .none
        } 
    }
    
}

private extension AppFlow {
    
    /**
     FlowContributors 발생할.. 다음 항목을 나타낸다.
     - .mutiple:  여러 FlowContributorsr가 Flow에 기여
     - .one: 하나의 FlowContributorsr가 Flow에 기여
     - end: 이 Flow의 해제를 나타내며, 주어진 단계를 상위 Flow로 전달합니다. (breakPoint 걸어보면 상위 Flow의 navigation(to:)가 호출된다.
     - .none: 더 이상 탐색이 발생되지 않습니다.
     */
    
    func coordinatorToDashboard() -> FlowContributors {
        let dashboardFlow = DashboardFlow(with: self.provider)
        
        /// .created -> memoFlow의 root 파라메터를 클로저로 반환.
        Flows.use(dashboardFlow, when: .created) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        
        let nextStep = OneStepper(withSingleStep: SampleStep.dashboardIsRequired)
        
        return .one(flowContributor: .contribute(withNextPresentable: dashboardFlow,
                                                 withNextStepper: nextStep))
        
    }
    
}
