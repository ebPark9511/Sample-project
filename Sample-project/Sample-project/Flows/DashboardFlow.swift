//
//  DashboardFlow.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/12.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa
import RxFlow

class DashboardFlow: Flow {
    
    var root: Presentable { self.rootViewController }
     
    private let rootViewController = UITabBarController()
    private let provider: ServiceProviderType
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }

    init(with services: ServiceProviderType) {
        self.provider = services
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SampleStep else { return .none }

        switch step {
        case .dashboardIsRequired:
            return coordinateToDashboard()
        default:
            return .none
        }
    }
    
}

private extension DashboardFlow {
    
    private func coordinateToDashboard() -> FlowContributors {
        
        let memoReadingFlow = MemoReadingFlow(with: self.provider)
        let githubSearchFlow = GithubSearchFlow()
        
        Flows.use(memoReadingFlow, githubSearchFlow, when: .created) { [unowned self] (root1: UINavigationController, root2: UINavigationController) in
            let tabBarItem1 = UITabBarItem(title: "Memo", image: nil, selectedImage: nil)
            let tabBarItem2 = UITabBarItem(title: "GithubSearch", image: nil, selectedImage: nil)
            
            root1.tabBarItem = tabBarItem1
            root1.title = "Memo"
            root2.tabBarItem = tabBarItem2
            root2.title = "GithubSearch"
            
            self.rootViewController.setViewControllers([root1, root2], animated: false)
        }
        
        return .multiple(
            flowContributors: [
                .contribute(
                    withNextPresentable: memoReadingFlow,
                    withNextStepper: OneStepper(withSingleStep: SampleStep.memoList)
                ),
                
                    .contribute(
                        withNextPresentable: githubSearchFlow,
                        withNextStepper: OneStepper(withSingleStep: SampleStep.githubSearchMain)
                    )
            ]
        )
    }
}
                            
