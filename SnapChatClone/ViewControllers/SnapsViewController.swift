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
            snap.key = snapshot.key
            
            //Added to snaps array
            self.snaps.append(snap)
            self.tableView.reloadData()
         
        })
        
        //Load users from Firebase Database
        //Getting rid of one of the objects
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childRemoved, with: {(snapshot) in
            print(snapshot)
            //Looping through array to remove a specific index
            var index = 0
            for snap in self.snaps {
                if snap.key == snapshot.key {
                    self.snaps.remove(at: index)
                }
                index += 1
            }
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        //Pass snap that was selected
        performSegue(withIdentifier: "viewSnapSegue", sender: snap)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Only run this code if it is the viewSnapSegue as SnapsViewController is connected to two viewControllers
        if segue.identifier == "viewSnapSegue" {
            let nextViewController = segue.destination as! ViewSnapViewController
            nextViewController.snap = sender as! Snap
        }
    }
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
