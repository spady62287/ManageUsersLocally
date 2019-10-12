//
//  BaseNavigator.swift
//  SwiftCodingTest
//
//  Created by DANIEL SPADY on 10/1/19.
//  Copyright © 2019 DANIEL SPADY. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Base Navigator protocol
@objc protocol BaseNavigator {
    @objc optional func navigatorWillTransitionToViewController(destinationViewController: UIViewController)
}

// MARK: - Navigation Type
enum BaseNavigationTransitionType {
    case BaseNavigationTransitionTypePush
    case BaseNavigationTransitionTypeModal
}

// MARK: - Navigation to Features
extension BaseNavigator {
    
    func navigateToFeature(feature: String, identifier: String, fromViewController: UIViewController, transitionType: BaseNavigationTransitionType) {
        
        let targetStoryboard = UIStoryboard.init(name: feature, bundle: nil)
        let targetVC = targetStoryboard.instantiateViewController(withIdentifier: identifier)
        
        if let delegate = fromViewController as? BaseNavigator {
            delegate.navigatorWillTransitionToViewController!(destinationViewController: targetVC)
        }
        
        switch transitionType {
            case .BaseNavigationTransitionTypePush:
                fromViewController.navigationController?.pushViewController(targetVC, animated: true)
            case .BaseNavigationTransitionTypeModal:
                fromViewController.present(targetVC, animated: true) {}
        }
    }
}
