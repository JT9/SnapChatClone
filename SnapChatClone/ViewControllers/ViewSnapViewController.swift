//
//  ViewSnapViewController.swift
//  SnapChatClone
//
//  Created by Caleb Tsosie on 10/11/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ViewSnapViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = snap.descrip
        imageView.sd_setImage(with: URL(string: snap.imageURl))
    }
    
    //Will run when leaving view
    override func viewWillDisappear(_ animated: Bool) {
        //print("Goodbye")
        //Remove image from database from current user
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").child(snap.key).removeValue()
        Storage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
            print("We deleted the pic")
        }
    }

}
