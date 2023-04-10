//
//  UIViewController+Rx.swift
//  RxMemo
//
//  Created by 박은비 on 2023/04/10.
//

import UIKit

import RxCocoa
import RxSwift

public extension Reactive where Base: UIViewController {
    
    /**
     RxSwift에서 제공하는 메서드 스위즐링.
     
     메서드가 호출 되기 전에 호출된다.
     public func sentMessage(_ selector: Selector) -> Observable<[Any]>
     
     
     메서드가 호출된 후에 호출된다.
     public func methodInvoked(_ selector: Selector) -> Observable<[Any]>
     */
    
    var viewDidLoad: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }
    
    var viewWillAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    var viewDidAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    var viewWillDisappear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillDisappear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    var viewDidDisappear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidDisappear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    
}
