//
//  MemoWritingFlow.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/10.
//

import UIKit

import RxFlow

/// 메모 보기 플로우
class MemoWritingFlow: Flow {
    
    var root: Presentable { self.rootViewController }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.view.backgroundColor = .white
        return viewController
    }()
    
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SampleStep else { return FlowContributors.none }
        
        switch step {
            
        case .memoComposeIsRequired:
            return coordinateToMemoCompose()
            
        case .memoComposeIsComplete:
            return .end(forwardToParentFlowWithStep: SampleStep.memoComposeIsComplete)

        default:
            return .none
        }
    }
     
}
 
// MARK: Method

private extension MemoWritingFlow {
    
    func coordinateToMemoCompose() -> FlowContributors {
        let reactor = MemoComposeReactor(provider: self.provider)
        
        let viewController = UIStoryboard(
            name: "MemoComposeViewController",
            bundle: nil
        )
            .instantiateInitialViewController()
        as! MemoComposeViewController
        
        viewController.title = "새 메모"
        
        viewController.loadViewIfNeeded()
        
        viewController.bind(reactor: reactor)
        
        self.rootViewController.setViewControllers([viewController],
                                                   animated: true)
        
        return .one(
            flowContributor: .contribute(withNextPresentable: viewController,
                                         withNextStepper: reactor)
        )
    }
}
