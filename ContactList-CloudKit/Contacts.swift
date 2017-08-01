//
//  Contacts.swift
//  ContactList-CloudKit
//
//  Created by Luis Puentes on 7/30/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import Foundation
import CloudKit

class Contacts {
    
    static let typeKey = "Contact"
    static let namekey = "name"
    static let numberKey = "phoneNumber"
    static let emailKey = "email"
    static let identifierKey = "identifier"
    
    var name: String
    var phoneNumber: Int?
    var email: String?
    var cloudKitRecordID: CKRecordID?
    
    init(name: String, phoneNumber: Int?, email: String) {
        
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    init?(cloudKitRecord: CKRecord) {
        
        guard let name = cloudKitRecord[Contacts.namekey] as? String,
            let phoneNumber = cloudKitRecord[Contacts.numberKey] as? Int,
            let email = cloudKitRecord[Contacts.emailKey] as? String else { return nil }
        
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.cloudKitRecordID = cloudKitRecord.recordID
    }
    
    var cloudKitRecord: CKRecord {
        
        let recordID = cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        let record = CKRecord(recordType: Contacts.typeKey, recordID: recordID)
        
        record.setValue(name, forKey: Contacts.namekey)
        record.setValue(phoneNumber, forKey: Contacts.numberKey)
        record.setValue(email, forKey: Contacts.emailKey)
        
        self.cloudKitRecordID = recordID
        
        return record
    }
}

extension Contacts: Equatable {
    
    static func ==(lhs: Contacts, rhs: Contacts) -> Bool {
        
        return lhs.cloudKitRecordID == rhs.cloudKitRecordID
    }
}
