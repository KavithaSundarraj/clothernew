//
//  CreateViewController.swift
//  Clother
//
//  Created by DSV on 2018-04-16.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit
//importing firebase
import Firebase

class CreateViewController: UIViewController, UITextFieldDelegate {
    
    // Outlet for Email and Password field
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var create: UIButton!
    @IBOutlet weak var guest: UIButton!
    //Back Button - to connect to Main Page
    @IBAction func goToMainPage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func guestLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "guestSegue", sender: self)
    }
    
    //Create Button - Create new user with email and password and perform segue to Menu page
    @IBAction func createButton(_ sender: UIButton) {
        //if email textfield is empty - create alert
        if EmailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
        }
        
            if Connectivity.isConnectedToInternet() {
               // print("Yes! internet is available.")
            Auth.auth().createUser(withEmail: EmailTextField.text!, password: PasswordTextField.text!, completion: { (user: User?, error) in
            if error == nil {
                //print("success")
               // print(User.self)
                self.performSegue(withIdentifier: "createSegue", sender: self)
            }
            else{
                //To alert based on error
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                //To reset textfields
                //self.EmailTextField.text=""
                //self.PasswordTextField.text=""
                }
                })
               }
            else{
                //print("Yes! internet is not available.")
                //To perform alert message based on error
                let alertController = UIAlertController(title: "Error", message: "No internet connection", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
               
        }
        
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
       //create.layer.cornerRadius = 6
        //initialising firebase
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        self.EmailTextField.delegate = self
        self.PasswordTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
