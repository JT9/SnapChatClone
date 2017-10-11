//
//  SelectUserViewController.swift
//  SnapChatClone
//
//  Created by Caleb Tsosie on 10/10/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
import Firebase

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    //Empty array to hold users
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //Load users from Firebase Database
        Database.database().reference().child("users").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            //From User.swift
            let user = User()
            let snapshotValue = snapshot.value as? NSDictionary
            user.email = (snapshotValue!["email"] as? String)!
            user.uid = snapshot.key
            
            self.users.append(user)
            self.tableView.reloadData()
        })
        
    }
    
    //How many users per row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    //Displays cells with user text as label
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }

}
