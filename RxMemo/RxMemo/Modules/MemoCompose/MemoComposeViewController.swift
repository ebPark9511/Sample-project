//
//  MemoComposeViewController.swift
//  RxMemo
//
//  Created by 박은비 on 2023/04/07.
//

import UIKit

import RxCocoa
import ReactorKit

final class MemoComposeViewController: UIViewController, StoryboardView {
    
    var disposeBag = DisposeBag()
     
    @IBOutlet private weak var contentTextView: UITextView!
    
    private var cancelButton: UIBarButtonItem! = {
        let button = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.cancel,
            target: nil,
            action: nil
        )
        return button
    }()

    private var saveButton: UIBarButtonItem! = {
        let button = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.save,
            target: nil,
            action: nil
        )
        return button
    }()

    
    deinit { print("\(type(of: self)): \(#function)") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setLeftBarButton(cancelButton, animated: false)
        self.navigationItem.setRightBarButton(saveButton, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        disposeBag = DisposeBag()
    }

    func bind(reactor: MemoComposeReactor) {
        bindAction(reactor)
    }
    
    private func bindAction(_ reactor: MemoComposeReactor) {
        self.cancelButton.rx.tap
            .map { Reactor.Action.cancel }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        self.saveButton.rx.tap
            .map { _ in self.contentTextView.text }
            .map { Reactor.Action.save(content: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }

}


