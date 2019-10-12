//
//  BaseViewController.swift
//  SwiftCodingTest
//
//  Created by DANIEL SPADY on 10/1/19.
//  Copyright © 2019 DANIEL SPADY. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, BaseNavigator {
    
    //MARK: - Properties
    var baseScrollView: UIScrollView? = nil
    var activeView: UIView? = nil
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterForKeyboardNotifications()
    }
    
    //MARK: - Keyboard Notification and Handler methods
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }
    
    //MARK: - Scolls view to top if field is hidden by keyboard
    @objc func keyboardWillShow(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                let bottomSafeAreaInset = self.view.safeAreaInsets.bottom
                var keyboardHeight = keyboardSize.height
                if bottomSafeAreaInset > 0.0 {
                    keyboardHeight = keyboardSize.height - bottomSafeAreaInset
                }
                
                let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
                
                if let scrollView = self.baseScrollView {
                    scrollView.contentInset = contentInsets
                    scrollView.scrollIndicatorInsets = contentInsets
                    
                    var viewRect = self.view.frame
                    viewRect.size.height -= keyboardHeight
                    
                    if let activeView = self.activeView {
                        if viewRect.contains(activeView.frame.origin) {
                            scrollView.setContentOffset(CGPoint.init(x: 0, y: keyboardHeight), animated: true)
                        }
                    }
                }
           }
        }
    }
    
    //MARK: - Scolls view to defualt position after keyboard is hidden
    @objc func keyboardWillHide(_ notification: Notification) {
        
        if let scrollView = self.baseScrollView {
            let contentInset = UIEdgeInsets.zero

            scrollView.contentInset = contentInset
            scrollView.scrollIndicatorInsets = contentInset
        }
    }
    
    //MARK: - Present Alert to User
    func showAlertControllerWithTitle(title: String, message: String) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: AppConstants.OkAlert, style: .default) { (action) in
            
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true) {}
    }
    
}
