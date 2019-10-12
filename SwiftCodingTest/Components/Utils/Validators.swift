//
//  Validators.swift
//  SwiftCodingTest
//
//  Created by DANIEL SPADY on 10/1/19.
//  Copyright © 2019 DANIEL SPADY. All rights reserved.
//

import Foundation

class Validators {
    
    // MARK: - Appliation Form Requirements

    static let minLength = 5
    static let maxLength = 12
    static let stringLengthLimit = 20

    static let passwordMinAlphaCharRegEx = ".*[a-z]+.*"
    static let passwordMinNumericCharRegEx = ".*[0-9]+.*"
    static let passwordNoSequenceCharRegEx = "(\\w{2,})\\1"
    
    // MARK: Used to restrict user to only enter Numbers and Letters
    static func isAlphaNumeric(value: NSString) -> Bool {
        let charOtherThanAlphaNumeric: CharacterSet = CharacterSet.alphanumerics.inverted
        return value.rangeOfCharacter(from: charOtherThanAlphaNumeric).location == NSNotFound
    }
    
    // MARK: Check Minimum String Length of value
    static func isMinimumLength(value: NSString) -> Bool {
        return value.length > minLength
    }

    // MARK: Check Max String Lenghth of value
    static func isMaximumLength(value: NSString) -> Bool {
        return value.length > maxLength
    }
    
    // MARK: Limit Length of Textfield
    static func isTextfieldLimit(value: NSString) -> Bool {
        return value.length > stringLengthLimit
    }
    
    // MARK: Check to see if value is a valid string
    static func isValidString(value: NSString) -> Bool {
        if value.isKind(of: NSString.self) {
            let trimmedString: NSString = value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
            
            if isMinimumLength(value: trimmedString) {
                return true
            }
        }
        
        return false
    }
    
    // MARK: Validate Password on Submission
    static func isValidPassword(password: NSString) -> Bool {
        return isPasswordSequenceCompliant(password: password) && isPasswordAlphaCompliant(password: password) && isPasswordNumericCompliant(password: password) && isMaximumLength(value: password) && isMinimumLength(value: password)
    }
    
    // MARK: Check to see if password contains alpha values
    static func isPasswordAlphaCompliant(password: NSString) -> Bool {
        let validatePassword: NSPredicate = NSPredicate.init(format: "SELF MATCHES %@", passwordMinAlphaCharRegEx)
        return validatePassword.evaluate(with: password)
    }
        
    // MARK: Check to see if password contains numberic values
    static func isPasswordNumericCompliant(password: NSString) -> Bool {
        let validatePassword: NSPredicate = NSPredicate.init(format: "SELF MATCHES %@", passwordMinNumericCharRegEx)
        return validatePassword.evaluate(with: password)
    }
    
    // MARK: Check to see if password contains a sequence
    static func isPasswordSequenceCompliant(password: NSString) -> Bool {
        let validatePassword: NSPredicate = NSPredicate.init(format: "SELF MATCHES %@", passwordNoSequenceCharRegEx)
        return !validatePassword.evaluate(with: password)
    }
}
