//
//  AddUserViewController.swift
//  SwiftCodingTest
//
//  Created by DANIEL SPADY on 10/1/19.
//  Copyright © 2019 DANIEL SPADY. All rights reserved.
//

import Foundation
import UIKit

class AddUserViewController: BaseViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var passwordRule1: UILabel!
    @IBOutlet weak var passwordRule2: UILabel!
    @IBOutlet weak var passwordRule3: UILabel!
    @IBOutlet weak var passwordRule4: UILabel!
    
    @IBOutlet weak var createPasswordLabel: UILabel!
    @IBOutlet weak var createUsernameLabel: UILabel!
    @IBOutlet weak var createFirstNameLabel: UILabel!
    @IBOutlet weak var createLastNameLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    // MARK: - Life Cycle Methods

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.baseScrollView = self.scrollView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.baseScrollView = nil
        self.activeView = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
        userNameTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self

        passwordRule1.text = AppConstants.PasswordRule1
        passwordRule2.text = AppConstants.PasswordRule2
        passwordRule3.text = AppConstants.PasswordRule3
        passwordRule4.text = AppConstants.PasswordRule4
    }
    
    // MARK: - Text Field Delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeView = textField
        
        ToggleColors.toggleColorWith(color: .red, label: passwordRule2)
        
        if textField == passwordTextField {
            toggleLabelColor(color: .red, textField: passwordTextField)
            ToggleColors.toggleColorWith(color: .red, label: passwordRule1)
            ToggleColors.toggleColorWith(color: .red, label: passwordRule3)
            ToggleColors.toggleColorWith(color: .red, label: passwordRule4)
        }
        
        if textField == userNameTextField {
            toggleLabelColor(color: .red, textField: userNameTextField)
        }
        
        if textField == firstNameTextField {
            toggleLabelColor(color: .red, textField: firstNameTextField)
        }

        if textField == lastNameTextField {
            toggleLabelColor(color: .red, textField: lastNameTextField)
        }
    }
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text!
        let newText = (oldText as NSString).replacingCharacters(in: range, with: string)

        var isStringValid = Validators.isAlphaNumeric(value: newText as NSString)
        
        if isStringValid {
            
            if Validators.isTextfieldLimit(value: newText as NSString) {
                isStringValid = false
            }
            
            if Validators.isMinimumLength(value: newText as NSString) {
                
                self.passwordRule2.textColor = UIColor.green
                
                if textField == passwordTextField {
                    toggleLabelColor(color: .green, textField: passwordTextField)
                }
                
                if textField == userNameTextField {
                    toggleLabelColor(color: .green, textField: userNameTextField)
                }
                
                if textField == firstNameTextField {
                    toggleLabelColor(color: .green, textField: firstNameTextField)
                }

                if textField == lastNameTextField {
                    toggleLabelColor(color: .green, textField: lastNameTextField)
                }
                
            } else {
                self.passwordRule2.textColor = UIColor.red
                
                if textField == passwordTextField {
                    toggleLabelColor(color: .red, textField: passwordTextField)
                }
                
                if textField == userNameTextField {
                    toggleLabelColor(color: .red, textField: userNameTextField)
                }
                
                if textField == firstNameTextField {
                    toggleLabelColor(color: .red, textField: firstNameTextField)
                }

                if textField == lastNameTextField {
                    toggleLabelColor(color: .red, textField: lastNameTextField)
                }
            }
            
            if textField == self.passwordTextField {
                
                if Validators.isPasswordNumericCompliant(password: newText as NSString) &&
                    Validators.isPasswordAlphaCompliant(password: newText as NSString) {
                    ToggleColors.toggleColorWith(color: .green, label: passwordRule1)
                    toggleLabelColor(color: .green, textField: passwordTextField)
                } else {
                    ToggleColors.toggleColorWith(color: .green, label: passwordRule1)
                    toggleLabelColor(color: .red, textField: passwordTextField)
                }
                
                if Validators.isMaximumLength(value: newText as NSString) {
                    ToggleColors.toggleColorWith(color: .green, label: passwordRule3)
                    toggleLabelColor(color: .green, textField: passwordTextField)
                } else {
                    ToggleColors.toggleColorWith(color: .red, label: passwordRule3)
                    toggleLabelColor(color: .red, textField: passwordTextField)
                }
                
                if Validators.isPasswordSequenceCompliant(password: newText as NSString) {
                    ToggleColors.toggleColorWith(color: .green, label: passwordRule4)
                    toggleLabelColor(color: .green, textField: passwordTextField)
                } else {
                    ToggleColors.toggleColorWith(color: .red, label: passwordRule4)
                    toggleLabelColor(color: .red, textField: passwordTextField)
                }
            }
            
            return isStringValid
        }
        
        return isStringValid
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeView = textField
        
        ToggleColors.toggleColorWith(color: .black, label: passwordRule2)
        
        if textField == passwordTextField {
            toggleLabelColor(color: .black, textField: passwordTextField)
            ToggleColors.toggleColorWith(color: .black, label: passwordRule1)
            ToggleColors.toggleColorWith(color: .black, label: passwordRule3)
            ToggleColors.toggleColorWith(color: .black, label: passwordRule4)
        }
        
        if textField == userNameTextField {
            toggleLabelColor(color: .black, textField: userNameTextField)
        }
        
        if textField == firstNameTextField {
            toggleLabelColor(color: .black, textField: firstNameTextField)
        }

        if textField == lastNameTextField {
            toggleLabelColor(color: .black, textField: lastNameTextField)
        }
    }
    
    // MARK: - IBActions

    @IBAction func saveUserTapped(_ sender: Any) {
                
        if Validators.isValidPassword(password: self.passwordTextField.text! as NSString) &&
            Validators.isValidString(value: self.userNameTextField.text! as NSString) &&
            Validators.isValidString(value: self.lastNameTextField.text! as NSString) &&
            Validators.isValidString(value: self.firstNameTextField.text! as NSString) {

            let newUser = UserInformationModel.init(firstName: self.firstNameTextField?.text as NSString?, lastName: self.lastNameTextField?.text as NSString?, password: self.passwordTextField?.text as NSString?, username: self.userNameTextField?.text as NSString?)

            DataSessionManager.updateSessionWithUser(user: newUser)

            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: Notification.Name(AppConstants.AddUserNotification), object: nil)
            }
            
        } else {
            self.showAlertControllerWithTitle(title: AppConstants.AlertTitle, message: AppConstants.AlertMessage)
        }
    }
    
    func toggleLabelColor(color: ColorToggle, textField: UITextField) {
        
        if textField == passwordTextField {
            ToggleColors.toggleColorWith(color: color, label: createPasswordLabel)
        }
        
        if textField == userNameTextField {
            ToggleColors.toggleColorWith(color: color, label: createUsernameLabel)
        }
        
        if textField == firstNameTextField {
            ToggleColors.toggleColorWith(color: color, label: createFirstNameLabel)
        }
        
        if textField == lastNameTextField {
            ToggleColors.toggleColorWith(color: color, label: createLastNameLabel)
        }
    }
}
