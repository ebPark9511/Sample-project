//
//  MemoReadingFlow.swift
//  RxMemo
//
//  Created by 박은비 on 2023/04/09.
//

import UIKit

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

        case .memoDetail:
            return coordinateToMemoDetail() // 메모식별값필요
            
        case .memoComposeIsRequired:
            return coordinateToMemoCompose()
            
        case .memoComposeIsComplete:
            self.rootViewController.presentedViewController?.dismiss(animated: true)

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
    
    func coordinateToMemoDetail() -> FlowContributors {
        let reactor = MemoDetailReactor(initialState: .init())
        
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
        let memoWritingFlow = MemoWritingFlow(provider: self.provider)
        
        Flows.use(memoWritingFlow, when: .created) { [unowned self] root in
            self.rootViewController.present(root, animated: true)
        }
        
        let nextStep = OneStepper(withSingleStep: SampleStep.memoComposeIsRequired)
        
        return .one(flowContributor: .contribute(withNextPresentable: memoWritingFlow,
                                                 withNextStepper: nextStep))
    }
    
    @objc func didTap() {
        print("test")
    }
}
