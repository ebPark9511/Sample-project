//
//  UITextView+Rx.swift
//  RxMemo
//
//  Created by 박은비 on 2023/04/10.
//

import UIKit

import RxCocoa
import RxSwift

public extension Reactive where Base: UITextView {
    
//    var isFirstResponder: ControlEvent<Bool> {
//        
//        isFirstResponder
//        
//    }
//    
    
}

//extension Reactive where Base: UIScrollView {
//
//    var isScrollBottom: ControlEvent<Bool> {
//
//        return ControlEvent(events: contentOffset.asObservable()
//            .filter { _ in base.contentSize.height > 0 }
//            .map { element -> Bool in
//                element.y + base.frame.height > base.contentSize.height
//            }
//            .distinctUntilChanged()
//        )
//    }
//}
