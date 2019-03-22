/*:
 * Extension+UIViewController.swift
 * Created by Weslie
 * Copyright © 2019 Weslie. All rights reserved.
 */

import UIKit

/// Define swizzling function
private let swizzling: (AnyClass, Selector, Selector) -> Void = { forClass, originSelector, swizzledSelector in
    let originalMethod = class_getInstanceMethod(forClass, originSelector)
    let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
    method_exchangeImplementations(originalMethod!, swizzledMethod!)
}

extension UIViewController {
    
    /// Swizzle UIViewController view did load
    static let classInit: Void = {
        let originalSelector = #selector(viewDidLoad)
        let swizzledSelector = #selector(weslie_viewDidLoad)
        swizzling(UIViewController.self, originalSelector, swizzledSelector)
    }()
    
    @objc func weslie_viewDidLoad() {
        weslie_viewDidLoad()
        /// Custom function implementation
    }
    
}
