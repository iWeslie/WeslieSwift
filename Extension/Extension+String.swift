/*:
 * Extension+String.swift
 * Created by Weslie
 * Copyright © 2019 Weslie. All rights reserved.
 */

extension String {
    
    /// Replace char in string at specific index
    @discardableResult
    func replace(at index: Int, for newChar: Character) -> String {
        var chars = Array(self)
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
    
    /// Judge if the string is empty
    var isEmptyString: Bool {
        get {
            if self.replacingOccurrences(of: " ", with: "") == "" || self == "" {
                return true
            } else {
                return false
            }
        }
        set { }
    }
    
    /// Judge wheather the phone number is valid or not
    var isValidPhoneNumber: Bool {
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
    
    /// Judge wheather the id card number is valid or not
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
    
    /// Judge wheather the email is valid or not
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
    
    /// Judge wheather the password is valid or not
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

