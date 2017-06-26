//
//  SignUpViewController.swift
//  ParseChat
//
//  Created by Michael Hamlett on 6/26/17.
//  Copyright © 2017 Michael Hamlett. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var usernameLabel: UITextField!
    
    let alertController = UIAlertController(title: "Error", message: "Message", preferredStyle: .alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let OKAction = UIAlertAction(title:"OK", style: .default) { (action) in
            
        }
        
        alertController.addAction(OKAction)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newUserSignUp(_ sender: Any) {
        if usernameLabel.text!.isEmpty || emailLabel.text!.isEmpty || passwordLabel.text!.isEmpty {
            alertController.message = "A required field is empty"
            present(alertController, animated: true) {
                
            }
        } else {
            print("start new user setup")
            let newUser = PFUser()
            
            
            
            newUser.username = usernameLabel.text
            newUser.email = emailLabel.text
            newUser.password = passwordLabel.text
            
            //print("\(usernameLabel.text)")
            //print(newUser.email as! String)
            //print(newUser.password as! String)
            
            print("register new user")
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                    self.alertController.message = error.localizedDescription
                    self.present(self.alertController, animated: true) {
                        
                    }
                    
                }
                else {
                    print("User Registered Successfully")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
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
