//
//  ContactListTableViewController.swift
//  ContactList-CloudKit
//
//  Created by Luis Puentes on 8/1/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactsController.shared.contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let contact = ContactsController.shared.contacts[indexPath.row]
        
        cell.textLabel?.text = contact.name

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contact = ContactsController.shared.contacts[indexPath.row]
            ContactsController.shared.delete(contact: contact)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            guard let destinationVC = segue.destination as? ContactDetailsViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            destinationVC.contact = ContactsController.shared.contacts[indexPath.row]
        }
    }
}
