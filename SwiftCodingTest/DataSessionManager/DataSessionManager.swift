//
//  DataSessionManager.swift
//  SwiftCodingTest
//
//  Created by DANIEL SPADY on 10/1/19.
//  Copyright © 2019 DANIEL SPADY. All rights reserved.
//

import Foundation

class DataSessionManager {
    
    // MARK: - Properties
    private static var sharedDataSessionManager: DataSessionManager = {
        let dataSessionManager = DataSessionManager()

        return dataSessionManager
    }()

    // MARK: - Array of Users
    var arrayOfUsers: Array<UserInformationModel>?
    
    // MARK: Initialization
    private init() {
        arrayOfUsers = []
        
        // Load Saved Users from last Session
        arrayOfUsers = DataSessionManager.loadUsers()
    }

    // MARK: - Accessors
    class func shared() -> DataSessionManager {
        return sharedDataSessionManager
    }
    
    // MARK: Update Session with User
    class func updateSessionWithUser(user: UserInformationModel) {
        shared().arrayOfUsers?.append(user)
                
        do {
            try saveUsers()
        } catch  {
            print(error)
        }
        
        wrapPasswordInKeychain(user: user)
    }
        
    // MARK: Save Users from this session
    class func saveUsers() throws {
        if let array = shared().arrayOfUsers {
            let encodedData: Data = try NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: true)
            let userDefaults = UserDefaults.standard
            userDefaults.set(encodedData, forKey: AppConstants.UserObjectKey)
            userDefaults.synchronize()
        }
    }
        
    // MARK: Load users from previous sessions
    static func loadUsers() -> [UserInformationModel]? {
        guard
            let unarchivedObject = UserDefaults.standard.data(forKey: AppConstants.UserObjectKey)
        else {
            return nil
        }
        do {
            guard let array = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedObject) as? [UserInformationModel] else {
                fatalError("UserInformationModel - Can't get Array")
            }
            return array
        } catch {
            fatalError("UserInformationModel - Can't encode data: \(error)")
        }
    }
    
    // MARK: Fetch Password from User in Keychain
    class func fetchPasswordInKeychain(user: UserInformationModel) -> NSString? {
        if let username = user.username {
            let passwordData = KeychainWrapper.load(key: username)
            
            if let data = passwordData {
                return NSString.init(data: data, encoding: String.Encoding.utf8.rawValue)
            }
        }
        return nil
    }
    
    // MARK: Wrap Password in Keychain print SSOstatus
    class func wrapPasswordInKeychain(user: UserInformationModel) {
        if let password = user.password, let username = user.username {
            let passwordData = password.data(using: String.Encoding.utf8.rawValue)!
            let resultCode = KeychainWrapper.save(key: username, data: passwordData)
            
            switch resultCode {
                case errSecSuccess:
                    print("Keychain Status: No error.")
                case errSecUnimplemented:
                    print("Keychain Status: Function or operation not implemented.")
                case errSecIO:
                    print("Keychain Status: I/O error (bummers)")
                case errSecOpWr:
                    print("Keychain Status: File already open with with write permission")
                case errSecParam:
                    print("Keychain Status: One or more parameters passed to a function where not valid.")
                case errSecAllocate:
                    print("Keychain Status: Failed to allocate memory.")
                case errSecUserCanceled:
                    print("Keychain Status: User canceled the operation.")
                case errSecBadReq:
                    print("Keychain Status: Bad parameter or invalid state for operation.")
                case errSecInternalComponent:
                    print("Keychain Status: Internal Component")
                case errSecNotAvailable:
                    print("Keychain Status: No keychain is available. You may need to restart your computer.")
                case errSecDuplicateItem:
                    print("Keychain Status: The specified item already exists in the keychain.")
                case errSecItemNotFound:
                    print("Keychain Status: The specified item could not be found in the keychain.")
                case errSecInteractionNotAllowed:
                    print("Keychain Status: User interaction is not allowed.")
                case errSecDecode:
                    print("Keychain Status: Unable to decode the provided data.")
                case errSecAuthFailed:
                    print("Keychain Status: The user name or passphrase you entered is not correct.")
                default:
                    print("Keychain Status: Unknown. (\(resultCode))")
            }
        }
    }
    
}

