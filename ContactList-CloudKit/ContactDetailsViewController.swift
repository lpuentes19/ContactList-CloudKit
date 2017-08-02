//
//  ContactDetailsViewController.swift
//  ContactList-CloudKit
//
//  Created by Luis Puentes on 8/1/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    var contact: Contacts? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        
        guard let contact = contact, isViewLoaded else { return }
        
        title = "Edit Contact"
        nameTextField.text = contact.name
        phoneTextField.text = "\(String(describing: contact.phoneNumber))"
        emailTextField.text = contact.email
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let name = nameTextField.text, !name.isEmpty,
            let phoneNumber = Int(phoneTextField.text!),
            let email = emailTextField.text else { return }
        
        if let contact = contact {
            
            ContactsController.shared.modify(contact: contact, name: name, phoneNumber: phoneNumber, email: email)
        } else {
            
            ContactsController.shared.addContacts(name: name, phoneNumber: phoneNumber, email: email)
        }
        navigationController?.popViewController(animated: true)
    }
}
