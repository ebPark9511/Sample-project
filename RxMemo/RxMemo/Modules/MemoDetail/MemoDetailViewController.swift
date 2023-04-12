//
//  MemoDetailViewController.swift
//  RxMemo
//
//  Created by 박은비 on 2023/04/07.
//

import UIKit

import ReactorKit

class MemoDetailViewController: UIViewController, StoryboardView {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UITextView!
    
    @IBOutlet private weak var deleteButton: UIBarButtonItem!
    
    deinit { print("\(type(of: self)): \(#function)") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bind(reactor: MemoDetailReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: MemoDetailReactor) {
        self.deleteButton.rx.tap
            .map { Reactor.Action.delete }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
    
    private func bindState(_ reactor: MemoDetailReactor) {
        reactor.state
            .compactMap { $0.memo?.insertDate.description }
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.memo?.content }
            .bind(to: self.contentLabel.rx.text)
            .disposed(by: disposeBag)
        
    }

}


