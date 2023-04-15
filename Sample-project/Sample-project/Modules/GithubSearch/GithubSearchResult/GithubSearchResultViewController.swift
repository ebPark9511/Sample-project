//
//  GithubSearchResultViewController.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/15.
//

import UIKit

import ReactorKit

final class GithubSearchResultViewController: UIViewController, StoryboardView {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    
    deinit { print("\(type(of: self)): \(#function)") }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        disposeBag = DisposeBag()
    }
    
    func bind(reactor: GithubSearchResultReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: GithubSearchResultReactor) {
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.loadData }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
    
    private func bindState(_ reactor: GithubSearchResultReactor) {
        reactor.state
            .compactMap { $0.repos }
            .bind(to: self.tableView.rx.items(cellIdentifier: "cell")) { row, repo, cell in
                cell.textLabel?.text = repo.description
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .observe(on: MainScheduler.instance)
            .filter { $0.isNetworkError == true }
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in self.showAlert() })
            .disposed(by: disposeBag)
        
        reactor.state
            .observe(on: MainScheduler.instance)
            .map { $0.isLoadingNextPage }
            .bind(to: self.indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
    }
    
    private func showAlert() {
        UIAlertController.alert(title: "Error", message: "네크워크 에러")
            .action(title: "확인", style: .default) { _ in }
            .present(to: self)
        
    }
}
