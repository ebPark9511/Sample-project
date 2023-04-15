//
//  GithubSearchMainViewController.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/12.
//

import Foundation
import UIKit

import ReactorKit

final class GithubSearchMainViewController: UIViewController, StoryboardView {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet private weak var button: UIButton!
    
    @IBOutlet private weak var textFlied: UITextField!
    
    deinit { print("\(type(of: self)): \(#function)") }
    
    func bind(reactor: GithubSearchMainReactor) {
        bindAction(reactor)
    }
    
    private func bindAction(_ reactor: GithubSearchMainReactor) {
        
        self.button.rx.tap
            .compactMap { self.textFlied.text }
            .filter { !$0.isEmpty }
            .map { Reactor.Action.click($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: GithubSearchMainReactor) {
        
    }
}
