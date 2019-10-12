//
//  ManageUsersNavigator.swift
//  SwiftCodingTest
//
//  Created by DANIEL SPADY on 10/1/19.
//  Copyright © 2019 DANIEL SPADY. All rights reserved.
//

import Foundation
import UIKit

class ManageUsersNavigator: BaseNavigator {
    
    // MARK: - Properties
    private static var sharedUserNavigator: ManageUsersNavigator = {
        let userNavigator = ManageUsersNavigator()

        return userNavigator
    }()

    // MARK: - Accessors
    class func shared() -> ManageUsersNavigator {
        return sharedUserNavigator
    }
    
    // MARK: - Screens To Navigate to
    
    func userDetailsViewController(viewController: UIViewController) {
        self.navigateToFeature(feature: AppConstants.ManageUserStoryboard, identifier: AppConstants.UserDetailsIdentifier, fromViewController: viewController, transitionType: .BaseNavigationTransitionTypePush)
    }
    
    func addUserViewController(viewController: UIViewController) {
        self.navigateToFeature(feature: AppConstants.ManageUserStoryboard, identifier: AppConstants.AddUserIdentifier, fromViewController: viewController, transitionType: .BaseNavigationTransitionTypeModal)
    }
    
}
