//
//  UserDetailsViewController.swift
//  TinderClone-Swift
//
//  Created by Robert Oneill on 17/02/2018.
//  Copyright © 2018 Parse. All rights reserved.
//

import UIKit
import Parse

class UserDetailsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var genderSwitch: UISwitch!
    
    @IBOutlet weak var interestedInSwitch: UISwitch!

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            userImage.image = image
            
        } else {
            
            self.createAlert(title: "Failed!", message: "There was a problem getting the image.")
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func importImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func updateUserDetails(_ sender: Any) {
        
        PFUser.current()?["isFemale"] = genderSwitch.isOn
        
        PFUser.current()?["isInterestedInWomen"] = interestedInSwitch.isOn
        
        let imageData = UIImageJPEGRepresentation(userImage.image!, 0.5)
        
        PFUser.current()?["photo"] = PFFile(name: "profile.png", data: imageData!)
        
        PFUser.current()?.saveInBackground(block: { (success, error) in
            
            if error != nil {
                
                var displayErrorMessage = "Please try again!"
                
                if let errorMessage = error?.localizedDescription as? String {
                    
                    displayErrorMessage = errorMessage
                    
                }
                
                self.createAlert(title: "Upload unsuccessful!", message: displayErrorMessage)
                
            } else {
                
                self.createAlert(title: "Upload Successful!", message: "Your user details have been saved.")
                self.performSegue(withIdentifier: "showSwipeViewController", sender: self)
            }
            
        })
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let isFemale = PFUser.current()?["isFemale"] as? Bool {
            
            genderSwitch.setOn(isFemale, animated: false)
            
        }
        
        if let isInterestedInWomen = PFUser.current()?["isInterestedInWomen"] as? Bool {
            
            interestedInSwitch.setOn(isInterestedInWomen, animated: false)
        
        }
        
        if let photo = PFUser.current()?["photo"] as? PFFile {
            
            photo.getDataInBackground(block: { (data, error) in
                
                if let imageData = data {
                    
                    if let downloadedImage = UIImage(data: imageData) {
                        
                        self.userImage.image = downloadedImage
                        
                    }
                    
                }
                
            })
            
        }
 
    }
        
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
