/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    var signUpMode = true

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpLogIn: UIButton!
    
    @IBOutlet weak var haveAnAccountLabel: UILabel!
    
    @IBOutlet weak var changeSignUpModeButton: UIButton!
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func signUpOrLogIn(_ sender: Any) {
        if usernameTextField.text == "" || passwordTextField.text == "" {
            
            createAlert(title: "Error in form", message: "Please enter a username and password")
            
        }
        
        if signUpMode {
            
            // Sign up mode
            
            let user = PFUser()
            
            user.username = usernameTextField.text
            user.password = passwordTextField.text
            
            /*
             
             Use if user write error occurs!
 
            let acl = PFACL()
            
            acl.getPublicWriteAccess = true
            
            user.acl = acl
 
            */
            
            user.signUpInBackground(block: { (success, error) in
                
                if error != nil {
                    
                    var displayErrorMessage = "Please try again!"
                    
                    if let errorMessage = error?.localizedDescription as? String {
                        
                        displayErrorMessage = errorMessage
                        
                    }
                    
                    self.createAlert(title: "Signup error", message: displayErrorMessage)
                    
                } else {
                    
                    self.performSegue(withIdentifier: "goToUserInfo", sender: sender)


                }
                
                
            })
            
            
        } else {
            
            // Log in mode
            
            PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                
                if error != nil {
                    
                    var displayErrorMessage = "Please try again!"
                    
                    if let errorMessage = error?.localizedDescription as? String {
                        
                        displayErrorMessage = errorMessage
                        
                    }
                    
                    self.createAlert(title: "Log In error", message: displayErrorMessage)
                    
                } else {
                    
                    self.performSegue(withIdentifier: "goToUserInfo", sender: sender)
                    
                }
                
                
            })
            
        }
        
    }
    
    @IBAction func changeSignUpMode(_ sender: Any) {
        
        if signUpMode {
            
            signUpLogIn.setTitle("Log In", for: [])
            
            changeSignUpModeButton.setTitle("Sign Up", for: [])
            
            haveAnAccountLabel.text = "Don't have an account?"
            
            signUpMode = false
            
        } else {
            
            signUpLogIn.setTitle("Sign Up", for: [])
            
            changeSignUpModeButton.setTitle("Log In", for: [])
            
            haveAnAccountLabel.text = "Already have an account?"
            
            signUpMode = true
            
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
            
            performSegue(withIdentifier: "goToUserInfo", sender: self)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
