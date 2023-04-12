//
//  GithubSearchMainViewController.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/12.
//

import Foundation
import UIKit

import ReactorKit

class GithubSearchMainViewController: UIViewController, StoryboardView {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func bind(reactor: GithubSearchMainReactor) {
        bindAction(reactor)
    }
    
    private func bindAction(_ reactor: GithubSearchMainReactor) {
        
    }
    
    private func bindState(_ reactor: GithubSearchMainReactor) {
        
    }
}
