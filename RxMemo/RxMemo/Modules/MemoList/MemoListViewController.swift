//
//  MemoListViewController.swift
//  RxMemo
//
//  Created by 박은비 on 2023/04/07.
//

import UIKit

import RxSwift
import ReactorKit
import RxFlow

class MemoListViewController: UIViewController, StoryboardView {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet private weak var writeButton: UIButton!
    @IBOutlet private weak var deatilButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bind(reactor: MemoListReactor) {
        bindAction(reactor)
    }
    
    private func bindAction(_ reactor: MemoListReactor) {
        
        deatilButton.rx.tap
            .map { Reactor.Action.detail }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        writeButton.rx.tap
            .map { Reactor.Action.write }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }

}

