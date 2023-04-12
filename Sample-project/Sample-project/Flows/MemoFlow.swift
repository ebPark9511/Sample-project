//
//  MemoReadingFlow.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/09.
//

import UIKit

import RxSwift
import RxCocoa
import RxFlow

/// 메모 보기 플로우
class MemoReadingFlow: Flow {
    
    var root: Presentable { self.rootViewController }

    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.view.backgroundColor = .white
        return viewController
    }()
    
    private let provider: ServiceProviderType
    
    init(with services: ServiceProviderType) {
        self.provider = services
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SampleStep else { return FlowContributors.none }
        
        switch step {
        case .memoList:
            return coordinateToMemoList()

        case .memoDetail(let memo):
            return coordinateToMemoDetail(memo: memo)
            
        case .memoComposeIsRequired:
            return coordinateToMemoCompose()
            
        case .memoComposeIsComplete, .memoDetailIsComplete:
            self.rootViewController.popViewController(animated: true)

        default:
            break
        }
        
        
        return .none
    }
     
}
 
// MARK: Method

private extension MemoReadingFlow {
    
    func coordinateToMemoList() -> FlowContributors {
        let reactor = MemoListReactor(provider: self.provider)
        
        let viewController = UIStoryboard(
            name: "MemoListViewController",
            bundle: nil
        )
            .instantiateInitialViewController()
        as! MemoListViewController
        
        viewController.title = "메모목록"
        viewController.loadViewIfNeeded()
        
        viewController.bind(reactor: reactor)
        
        self.rootViewController.setViewControllers([viewController], animated: true)
        
        return .one(
            flowContributor: .contribute(withNextPresentable: viewController,
                                         withNextStepper: reactor)
        )
    }
    
    func coordinateToMemoDetail(memo: Memo) -> FlowContributors {
        let reactor = MemoDetailReactor(initialState: .init(memo: memo), provider: self.provider)
        
        let viewController = UIStoryboard(
            name: "MemoDetailViewController",
            bundle: nil
        ).instantiateInitialViewController()
        as! MemoDetailViewController
        
        viewController.title = "메모상세"
        viewController.loadViewIfNeeded()
        
        viewController.bind(reactor: reactor)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(
            flowContributor: .contribute(withNextPresentable: viewController,
                                         withNextStepper: reactor)
        )
    }
    
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
        
        self.rootViewController.pushViewController(viewController, animated: true)
        
        return .one(
            flowContributor: .contribute(withNextPresentable: viewController,
                                         withNextStepper: reactor)
        )
    }
    
}
