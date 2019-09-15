/*:
 * MethodSwizzling.swift
 * Created by Weslie
 * Copyright © 2019 Weslie. All rights reserved.
 */

/// Define swizzling function
private let swizzling: (AnyClass, Selector, Selector) -> Void = { forClass, originSelector, swizzledSelector in
    let originalMethod = class_getInstanceMethod(forClass, originSelector)
    let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
    method_exchangeImplementations(originalMethod!, swizzledMethod!)
}

/// Swizzle UIViewController view did load
static let classInit: Void = {
    let originalSelector = #selector(viewDidLoad)
    let swizzledSelector = #selector(weslie_viewDidLoad)
    swizzling(UIViewController.self, originalSelector, swizzledSelector)
    
    let originalSelector2 = #selector(viewDidDisappear(_:))
    let swizzledSelector2 = #selector(weslie_viewDidDisappear(_:))
    swizzling(UIViewController.self, originalSelector2, swizzledSelector2)
    
}()

extension UIViewController {
    
    @objc private func weslie_viewDidLoad() {
        weslie_viewDidLoad()
        // ...
    }
    @objc private func weslie_viewDidDisappear(_ animated: Bool) {
        weslie_viewDidDisappear(animated)
        // ...
    }
}

// use here 
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    override init() {
        super.init()
        UIViewController.classInit
    }
}
