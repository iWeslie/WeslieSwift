/*:
 * DynamicallyAddMethod.swift
 * Created by Weslie
 * Copyright © 2019 Weslie. All rights reserved.
 */

extension UIButton {

    private struct AssociatedClass {
        var confirm: (UIView) -> Void
    }

    private struct AssociateKeys {
        static var eventClosure: AssociatedClass?
        static var userFavProperty = "com.simple.userFav"
    }

    private var eventClosureObj: AssociatedClass {
        set(value) {
            objc_setAssociatedObject(self, &AssociateKeys.eventClosure, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociateKeys.eventClosure) as! AssociatedClass
        }
    }

    // define associatedKey
    // static var buttonAssociatedKey: UnsafePointer<Any> {
    //     get {
    //         return UnsafePointer.init(bitPattern: "com.Simple.button.target.runtime".hashValue)!
    //     }
    // }
    
    /// Add action to UIButton using closure at runtime when touch up inside
    internal func touchUpInside(action: @escaping (UIView) -> Void) {
        let event = AssociatedClass(confirm: action)
        eventClosureObj = event
        addTarget(self, action: #selector(excuteEvent(_:)), for: .touchUpInside)
    }

    @objc private func excuteEvent(_ sender: UIButton) {
        guard let confirmationView = sender.superview as? UIView else {
            preconditionFailure("Button did not get super Confirmation View")
        }
        eventClosureObj.confirm(confirmationView)
    }
}