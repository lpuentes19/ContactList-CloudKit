//
//  Contacts.swift
//  ContactList-CloudKit
//
//  Created by Luis Puentes on 7/30/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import Foundation
import CloudKit

struct Contacts {
    
    static let typeKey = "Contact"
    static let namekey = "name"
    static let numberKey = "phoneNumber"
    static let emailKey = "email"
    static let identifierKey = "identifier"
    
    var name: String
    var phoneNumber: Int?
    var email: String?
    var cloudKitRecordID: CKRecordID?
    
    init?(cloudKitRecord: CKRecord) {
        
        guard let name = cloudKitRecord[Contacts.namekey] as? String,
            let phoneNumber = cloudKitRecord[Contacts.numberKey] as? Int,
            let email = cloudKitRecord[Contacts.emailKey] as? String else { return nil }
        
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.cloudKitRecordID = cloudKitRecord.recordID
    }
}
