//
//  ManageUsersViewController.swift
//  SwiftCodingTest
//
//  Created by DANIEL SPADY on 10/1/19.
//  Copyright © 2019 DANIEL SPADY. All rights reserved.
//

import Foundation
import UIKit

class ManageUsersViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets
    @IBOutlet weak var noUserView: UIView!
    @IBOutlet weak var userTableView: UITableView!
    
    // MARK: - Properties
    var userModelArray: Array<UserInformationModel>?
    var selectedUser: UserInformationModel?
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userTableView.delegate = self
        self.userTableView.dataSource = self
        self.userTableView.rowHeight = UITableView.automaticDimension
        self.userTableView.estimatedRowHeight = 50
        
        NotificationCenter.default.addObserver(self, selector: #selector(onUserAdded), name: NSNotification.Name(rawValue:AppConstants.AddUserNotification), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.userModelArray = DataSessionManager.shared().arrayOfUsers
        
        self.title = AppConstants.ManageUserTitle
        
        toggleTableView()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(NSNotification.Name(rawValue:AppConstants.AddUserNotification))
    }
    
    // MARK: - TableView Data Source, Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let userArray = self.userModelArray {
            return userArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.UserCell, for: indexPath) as! UserTableViewCell

        if let userArray = self.userModelArray {
            let user = userArray[(indexPath as NSIndexPath).row]
            cell.setUserCell(user: user)
        }
                
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let userArray = self.userModelArray {
            self.selectedUser = userArray[(indexPath as NSIndexPath).row]
        }
        
        ManageUsersNavigator.shared().userDetailsViewController(viewController: self)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - Base Navigator Delegate
    
    func navigatorWillTransitionToViewController(destinationViewController: UIViewController) {
        if destinationViewController.isKind(of: UserDetailsViewController.self) {
            (destinationViewController as! UserDetailsViewController).user = self.selectedUser
        }
    }
    
    // MARK: - Notification Delegate
    
    @objc func onUserAdded() {
        DispatchQueue.main.async {
            self.userModelArray = DataSessionManager.shared().arrayOfUsers
            self.toggleTableView()
        }
    }
    
    // MARK: - IBAction

    @IBAction func addNewUserTapped(_ sender: Any) {
        ManageUsersNavigator.shared().addUserViewController(viewController: self)
    }
    
    // MARK: - Toggle Table View

    func toggleTableView() {
        if let userArray = self.userModelArray {
            if userArray.count == 0 {
                self.userTableView.isHidden = true
                self.noUserView.isHidden = false
            } else {
                self.userTableView.isHidden = false
                self.noUserView.isHidden = true
                
                self.userTableView.reloadData()
            }

        } else {
            self.userTableView.isHidden = true
            self.noUserView.isHidden = false
        }
    }
    
}
