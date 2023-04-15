//
//  UIAlertController+.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/15.
//

import UIKit

extension UIAlertController {

  /*
   Alert ex :
       UIAlertController
           .alert(title: nil,
                  message: message,
                  style: .alert)
           .action(title: "AppStore", style: .default) { _ in
               if let url = URL(string: urlString) {
                   UIApplication.shared.open(url, options: [:])
               }
           }
           .action(title: "취소", style: .default) { _ in
           }
           .present(to: self)
   */

  /// `UIAlertController` Helper.
  static func alert(title: String?,
                    message: String?,
                    style: UIAlertController.Style = .alert) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    return alert
  }

  /// `UIAlertAction` Helper.
  @discardableResult
  func action(title: String?,
              style: UIAlertAction.Style = .default,
              completion: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
    let extractedExpr = UIAlertAction(title: title, style: style) { completion?($0) }
    let action = extractedExpr
    addAction(action)
    return self
  }

  /// 빌더 패턴을 통해 만들어진 `UIAlertController` present.
  func present(to viewController: UIViewController?,
               animated: Bool = true,
               completion: (() -> Void)? = nil) {
    DispatchQueue.main.async {
      if !(viewController?.presentedViewController is UIAlertController) {
        viewController?.present(self, animated: animated, completion: completion)
      }
    }
  }
}
