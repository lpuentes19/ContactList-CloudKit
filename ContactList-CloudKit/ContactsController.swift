//
//  ContactsController.swift
//  ContactList-CloudKit
//
//  Created by Luis Puentes on 7/31/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import Foundation
import CloudKit

class ContactsController {
    
    static let shared = ContactsController()
    
    var contacts = [Contacts]()
    
    // Saving contact to CloudKit
    func addContacts(name: String, phoneNumber: Int, email: String) {
        
        let contact = Contacts(name: name, phoneNumber: phoneNumber, email: email)
        
        let contactRecord = contact.cloudKitRecord
        
        CKContainer.default().publicCloudDatabase.save(contactRecord) { (record, error) in
            if let error = error {
                print("Error saving record to CloudKit: \(error)")
            }
            self.contacts.append(contact)
        }
    }
    
    
}

