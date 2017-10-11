//
//  SnapsViewController.swift
//  SnapChatClone
//
//  Created by Caleb Tsosie on 10/10/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
import Firebase
class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var snaps: [Snap] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup TableView
        tableView.dataSource = self
        tableView.delegate = self

        //Load users from Firebase Database
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            
            //From User.swift
            let snap = Snap()
            let snapshotValue = snapshot.value as? NSDictionary
            snap.imageURl = (snapshotValue!["imageURL"] as? String)!
            snap.from = (snapshotValue!["email"] as? String)!
            snap.descrip = (snapshotValue!["description"] as? String)!
            
            //Added to snaps array
            self.snaps.append(snap)
            self.tableView.reloadData()
         
        })
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let snap = snaps[indexPath.row]
        
        cell.textLabel?.text = snap.from
        
        return cell
    }

    @IBAction func logoutTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
