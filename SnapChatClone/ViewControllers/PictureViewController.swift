//
//  PictureViewController.swift
//  SnapChatClone
//
//  Created by Caleb Tsosie on 10/10/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
import Firebase

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var uuid = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func cameraTapped(_ sender: Any) {
        //Testing purposes for savedPhotosAlbum need to change to camera once on device
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    //User clicks on next button to upload their selected image
    @IBAction func nextTapped(_ sender: Any) {
        
        //Button is disabled when user clicks on it to prevent them from pushing it more than once
        nextButton.isEnabled = false
        
        let imagesFolder =
            Storage.storage().reference().child("images")
        
        //let imageData = UIImagePNGRepresentation(imageView.image!)!
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        
        imagesFolder.child("\(uuid).jpg").putData(imageData, metadata: nil, completion: {(metadata, error) in
            print("We tried to upload")
            if error != nil {
                print("We had an error:\(error)")
            } else {
                
                print(metadata?.downloadURL())
                
                //Move to another ViewController
                self.performSegue(withIdentifier: "selectUserSegue", sender: metadata?.downloadURL()!.absoluteString)
            }
        })
        
    }
    
    //To Upload image and pass to SelectUserViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! SelectUserViewController
        nextViewController.imageURL = sender as! String
        nextViewController.descrip = descriptionTextField.text!
        nextViewController.uuid = uuid
    }
    
}
