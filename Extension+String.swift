/*:
 * ConstantValue.swift
 * Created by Weslie
 * Copyright © 2018 Weslie. All rights reserved.
 */

extension String {

    /// Return a bool value if the string only contains spaces or empty
    var isEmptyString: Bool {
        get {
            if self.replacingOccurrences(of: " ", with: "") == "" || self == "" {
                return true
            } else {
                return false
            }
        }
        set {
            
        }
    }
    
    /// Return a bool value wheather the phone number is valid or not
    var isValidePhoneNumber: Bool {
        get {
            let mobileRE: String = "^((13[0-9])|(147)|(15[0-3,5-9])|(16[0,0-9])|(18[0,0-9])|(17[0-3,5-9]))\\d{8}$"
            let regex = NSPredicate(format: "SELF MATCHES %@", mobileRE)
            
            if regex.evaluate(with: self) == true {
                return true
            } else {
                return false
            }
        }
        set { }
    }
    
    /// Return a bool value wheather the ID card number is valid or not
    var isValidIDNumber: Bool {
        get {
            let mobileRE: String = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)"
            let regex = NSPredicate(format: "SELF MATCHES %@", mobileRE)
            
            if regex.evaluate(with: self) == true {
                return true
            } else {
                return false
            }
        }
        set { }
    }
    
    /// Return a bool value wheather the e-mail is valid or not
    var isValidEmail: Bool {
        get {
            let mobileRE: String = "^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$"
            let regex = NSPredicate(format: "SELF MATCHES %@", mobileRE)
            
            if regex.evaluate(with: self) == true {
                return true
            } else {
                return false
            }
        }
        set { }
    }
    
    /// Return a bool value if the password is valid
    var isValidPassword: Bool {
        get {
            let pwdRE: String = "^((?!\\d+$)(?![a-zA-Z]+$)[a-zA-Z\\d@#$%^&_+].{5,19})+$"
            let regex = NSPredicate(format: "SELF MATCHES %@", pwdRE)
            
            if regex.evaluate(with: self) == true {
                return true
            } else {
                return false
            }
        }
        set { }
    }
    
}

