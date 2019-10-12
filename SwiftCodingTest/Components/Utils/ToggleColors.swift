//
//  ToggleColors.swift
//  SwiftCodingTest
//
//  Created by DANIEL SPADY on 10/12/19.
//  Copyright © 2019 DANIEL SPADY. All rights reserved.
//

import Foundation
import UIKit

enum ColorToggle {
    case red
    case black
    case green
}

class ToggleColors {
    
    // MARK: Class file to change colors, optional custom colors
    
    // MARK: generic color toggle function
    static func toggleColorWith(color: ColorToggle, label: UILabel) {
        switch color {
        case .red:
            toggleRed(label: label)
        case .black:
            toggleBlack(label: label)
        case .green:
            toggleGreen(label: label)
        }
    }
    
    // MARK: Used to toggle Fields Red
    private static func toggleRed(label: UILabel) {
        label.textColor = UIColor.red
    }
    
    // MARK: Used to toggle Fields Black
    private static func toggleBlack(label: UILabel) {
        label.textColor = UIColor.black
    }
    
    // MARK: Used to toggle Fields Green
    private static func toggleGreen(label: UILabel) {
        label.textColor = UIColor.green
    }
    
}
