//
//  UserInformationModel.swift
//  SwiftCodingTest
//
//  Created by DANIEL SPADY on 10/1/19.
//  Copyright © 2019 DANIEL SPADY. All rights reserved.
//

import Foundation

// MARK: - Data Model

class UserInformationModel: NSObject, NSSecureCoding {
    
    static var supportsSecureCoding: Bool = true
    
    var firstName: NSString?
    var lastName: NSString?
    var password: NSString?
    var username: NSString?

    init(firstName: NSString?, lastName: NSString?, password: NSString?, username: NSString?) {
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.username = username
    }

    required convenience init(coder aDecoder: NSCoder) {
        let firstName = aDecoder.decodeObject(forKey: "firstName") as! NSString
        let lastName = aDecoder.decodeObject(forKey: "lastName") as! NSString
        let username = aDecoder.decodeObject(forKey: "username") as! NSString
        self.init(firstName: firstName, lastName: lastName, password: "", username: username)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(username, forKey: "username")
    }
}
