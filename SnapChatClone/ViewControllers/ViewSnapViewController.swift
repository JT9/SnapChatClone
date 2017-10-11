//
//  ViewSnapViewController.swift
//  SnapChatClone
//
//  Created by Caleb Tsosie on 10/11/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit

class ViewSnapViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = snap.descrip
    }

}
