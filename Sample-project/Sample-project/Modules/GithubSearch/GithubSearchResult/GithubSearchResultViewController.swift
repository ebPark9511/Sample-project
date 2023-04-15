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
    
    deinit { print("\(type(of: self)): \(#function)") }
    
    func bind(reactor: GithubSearchResultReactor) {
        bindAction(reactor)
    }
    
    private func bindAction(_ reactor: GithubSearchResultReactor) {
    
    }
    
    private func bindState(_ reactor: GithubSearchResultReactor) {
        
    }
}
