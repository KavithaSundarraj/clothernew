//
//  ChangeEmailViewController.swift
//  Clother
//
//  Created by DSV on 2018-04-27.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit
import Firebase

class ChangeEmailViewController: UIViewController , UITextFieldDelegate {
    var email: String? = nil
    let user = Auth.auth().currentUser
    
    @IBOutlet weak var currentUserEmail: UILabel!
    @IBOutlet weak var newEmail: UITextField!
    @IBOutlet weak var repeatEmail: UITextField!
    

    @IBAction func changeMailConfirmButton(_ sender: UIButton) {
        let email = newEmail.text
        let remail = repeatEmail.text
        if (email=="" && remail=="")
        {
            let alert = UIAlertController(title: "Please", message: "Enter Email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        if email == remail
        {
        user?.updateEmail(to: email!) { error in
            if let error = error {
                print(error)
                //print("Email updation Failure")
                
            } else {
              //print("Email updation success")
                let alert = UIAlertController(title: "Email Changed", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Continue", style: .default){
                    UIAlertAction in
                    self.performSegue(withIdentifier: "EmailUpdatedSegue", sender: self)
                })
                self.present(alert, animated: true)
                
            }
            }
            
        }
     else
        {
            let alert = UIAlertController(title: "Email Mismatch", message: "Please Re-Enter Email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.newEmail.text = ""
            self.repeatEmail.text = ""
        }
    }
    
    //Button to perform segue - to go back account page
    @IBAction func goBackAccountPage(_ sender: UIButton) {
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
        self.newEmail.delegate = self
        self.repeatEmail.delegate = self
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
