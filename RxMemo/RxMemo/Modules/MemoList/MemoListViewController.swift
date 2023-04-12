//
//  MemoListViewController.swift
//  RxMemo
//
//  Created by 박은비 on 2023/04/07.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit
import RxFlow

class MemoListViewController: UIViewController, StoryboardView {
    
    var disposeBag = DisposeBag()
     
    @IBOutlet private weak var listTableView: UITableView!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    
    private var addMemoButton: UIBarButtonItem! = {
        let button = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.add,
            target: nil,
            action: nil
        )
        return button
    }()
    
    deinit { print("\(type(of: self)): \(#function)") }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.setRightBarButton(addMemoButton, animated: false)
    }

    func bind(reactor: MemoListReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: MemoListReactor) {
        
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.loadData }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.addMemoButton.rx.tap
            .map { Reactor.Action.write }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.listTableView.rx.modelSelected(Memo.self)
            .map { Reactor.Action.select(memo: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: MemoListReactor) {
        
        reactor.state
            .compactMap { $0.memos }
            .bind(to: self.listTableView.rx.items(cellIdentifier: "cell")) { row, memo, cell in
                cell.textLabel?.text = memo.content
            }
            .disposed(by: disposeBag)
        
    }
    
    
}

