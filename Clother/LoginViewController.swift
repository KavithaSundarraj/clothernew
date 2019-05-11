//
//  LoginViewController.swift
//  Clother
//
//  Created by DSV on 2018-04-16.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    //Textfields for email and password
    @IBOutlet weak var emailTextFieldName: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //Sign In Button - To validate user email and password and perform segue to connect Menu Page
    @IBAction func signIn(_ sender: UIButton) {
        let email = emailTextFieldName.text
        let password = passwordTextField.text
        if emailTextFieldName.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
        }
        if Connectivity.isConnectedToInternet() {
           // print("Yes! internet is available.")
            // do some tasks..
       
        Auth.auth().signIn(withEmail: email!, password: password!, completion: { (user: User?, error) in
            if error == nil {
                self.performSegue(withIdentifier: "goToMenuPage", sender: self)
            }else{
                //To perform alert message based on error
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                //To reset the textfields to empty
                //self.emailTextFieldName.text = ""
                //self.passwordTextField.text = ""
            }
        })
         }
        else{
           // print("Yes! internet is not available.")
            //To perform alert message based on error
            let alertController = UIAlertController(title: "Error", message: "No internet connection", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //Back Button - to connect to Main page
    @IBAction func goToMainPage(_ sender: UIButton) {
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
  
        //initialising firebase
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        self.emailTextFieldName.delegate = self
        self.passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
