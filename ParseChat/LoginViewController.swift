//
//  ViewController.swift
//  ParseChat
//
//  Created by Michael Hamlett on 6/26/17.
//  Copyright © 2017 Michael Hamlett. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
    let alertController = UIAlertController(title: "Error", message: "Message", preferredStyle: .alert)

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let OKAction = UIAlertAction(title:"OK", style: .default) { (action) in
            
        }
        
        alertController.addAction(OKAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        if usernameLabel.text!.isEmpty ||  passwordLabel.text!.isEmpty {
            alertController.message = "A required field is empty"
            present(alertController, animated: true) {
                
            }
        }
        else{
                
                let username = self.usernameLabel.text ?? ""
                let password = self.passwordLabel.text ?? ""
            
                PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?,error: Error?) in
                    if let error = error {
                        print("User log in failed: \(error.localizedDescription)")
                        self.alertController.message = error.localizedDescription
                        self.present(self.alertController, animated: true) {
                            
                        }

                        
                    }
                    else{
                        print("User logged in successfully")
                        self.performSegue(withIdentifier: "chatSegue", sender: nil)
                        
                    }
                }
            }
    }

    @IBAction func signUpScreen(_ sender: Any) {
        performSegue(withIdentifier: "signUp", sender: sender)
    }
    
}

