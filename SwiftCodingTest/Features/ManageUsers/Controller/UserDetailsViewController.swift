//
//  UserDetailsViewController.swift
//  SwiftCodingTest
//
//  Created by DANIEL SPADY on 10/1/19.
//  Copyright © 2019 DANIEL SPADY. All rights reserved.
//

import Foundation
import UIKit

class UserDetailsViewController: BaseViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    // MARK: - Properties

    var user: UserInformationModel? = nil
    
    // MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = user {
            
            if let username = user.username {
                usernameLabel.text = username as String
            }
            
            if let firstName = user.firstName {
                firstNameLabel.text = firstName as String
            }

            if let lastName = user.lastName {
                lastNameLabel.text = lastName as String
            }
        }
    }
    
}

