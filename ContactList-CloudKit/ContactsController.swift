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
    
    // MARK: Saving contact to CloudKit
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
    
    // MARK: Fetching contacts from CloudKit
    func fetchContacts() {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: Contacts.typeKey, predicate: predicate)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (record, error) in
            if let error = error {
                print("Error fetching record from CloudKit: \(error)")
            }
            
            guard let record = record else { return }
            
            let contacts = record.flatMap { Contacts(cloudKitRecord: $0)}
            
            self.contacts = contacts
        }
    }
    
    // MARK: Delete contact from CloudKit
    func delete(contact: Contacts) {
        
        guard let index = contacts.index(of: contact) else { return }
        self.contacts.remove(at: index)
        
        CKContainer.default().publicCloudDatabase.delete(withRecordID: contact.cloudKitRecord.recordID) { (record, error) in
            if let error = error {
                print("Error deleting record from CloudKit: \(error)")
            }
        }
    }
    
    // MARK: Modifying contacts in CloudKit
    func modify(contact: Contacts, name: String, phoneNumber: Int, email: String) {
        
        contact.name = name
        contact.phoneNumber = phoneNumber
        contact.email = email
        
        let contactRecords = [contact.cloudKitRecord]
        
        let operation = CKModifyRecordsOperation(recordsToSave: contactRecords, recordIDsToDelete: nil)
        
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        
        operation.modifyRecordsCompletionBlock = { records, deletedRecordIDs, error in
            if let error = error {
                print("Error modifying record in CloudKit: \(error)")
            }
        }
        CKContainer.default().publicCloudDatabase.add(operation)
    }
}

