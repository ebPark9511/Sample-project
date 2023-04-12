//
//  GithubSearchFlow.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/12.
//

import UIKit

import RxCocoa
import RxFlow

/// 메모 보기 플로우
class GithubSearchFlow: Flow {
    
    var root: Presentable { self.rootViewController }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.view.backgroundColor = .white
        return viewController
    }()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SampleStep else { return FlowContributors.none }
        
        switch step {
            
        case .githubSearchMain:
            return coordinateToGithubSearch()

        default:
            return .none
        }
    }
     
}
 
// MARK: Method

private extension GithubSearchFlow {
    
    func coordinateToGithubSearch() -> FlowContributors {
        let reactor = GithubSearchMainReactor()
        
        let viewController = UIStoryboard(
            name: "GithubSearchMainViewController",
            bundle: nil
        )
            .instantiateInitialViewController()
        as! GithubSearchMainViewController
        
        viewController.title = "검색"
        
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
 
