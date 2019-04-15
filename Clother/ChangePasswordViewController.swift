//
//  ChangePasswordViewController.swift
//  Clother
//
//  Created by DSV on 2018-05-04.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit
import Firebase

class ChangePasswordViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    var email: String? = nil
    let user = Auth.auth().currentUser
    @IBOutlet weak var currentUserEmail: UILabel!
    
    
    @IBAction func ChangePasswordConfirmButton(_ sender: UIButton) {
        let pass = newPassword.text
        let rpass = repeatPassword.text
        let user = Auth.auth().currentUser
       /*To check both new password is same
         yes - password updated
         no - alert message to re-enter password
         */
        if (pass=="" && rpass=="")
         {
            let alert = UIAlertController(title: "Please", message: "Enter Password.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
             }
        if pass == rpass
        {
            user?.updatePassword(to: pass!) { error in
                     if let error = error {
                     print(error)
                     } else {
                     // Password updated.
                        print("success")
                        let alert = UIAlertController(title: "Password Changed", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Continue", style: .default){
                            UIAlertAction in
                            // Insert code to run on button click below
                            //self.dismiss(animated: true, completion: nil)
                            self.performSegue(withIdentifier: "PasswordUpdatedSegue", sender: self)
                            })
                        self.present(alert, animated: true)
                     
                     }
                     }
                    
                }
        else
        {
        let alert = UIAlertController(title: "Password Mismatch", message: "Please Re-Enter Password.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        
        self.present(alert, animated: true)
        self.repeatPassword.text = ""
        self.newPassword.text = ""
            
            }
     }
    
    //Button to perform segue - to go back account page
    @IBAction func goToAccountPageFromPasswordChange(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //Hide Keyboard when user touches outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Function to dismiss keyboard - presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        currentUserEmail.text = user?.email
        self.newPassword.delegate = self
        self.repeatPassword.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
