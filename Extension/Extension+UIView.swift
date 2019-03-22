/*:
 * Extension+UIView.swift
 * Created by Weslie
 * Copyright © 2019 Weslie. All rights reserved.
 */

import UIKit

extension UIView {
    
    /// return the current view controller of the view
    var viewController: UIViewController? {
        get {
            for view in sequence(first: self.superview, next: { $0?.superview }) {
                if let responder = view?.next {
                    if responder.isKind(of: UIViewController.self) {
                        return responder as? UIViewController
                    }
                }
            }
            return nil
        }
    }
}
