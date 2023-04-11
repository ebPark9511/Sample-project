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
    
    @IBOutlet private weak var contentTableView: UITableView!
    
    @IBOutlet private weak var deleteButton: UIBarButtonItem!
    @IBOutlet private weak var editButton: UIBarButtonItem!
    @IBOutlet private weak var shareButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bind(reactor: MemoDetailReactor) {
        
    }

}


