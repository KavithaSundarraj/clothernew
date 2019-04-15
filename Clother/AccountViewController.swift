//
//  AccountViewController.swift
//  Clother
//
//  Created by DSV on 2018-04-26.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {
  
    var email: String? = nil
    let user = Auth.auth().currentUser
    
    @IBOutlet weak var userEmail: UILabel!
    
    //To perform log out
    @IBAction func LogOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "LogOutSegue", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    //Button to perform segue - to go Change mail page
    @IBAction func goToChangeEmailPage(_ sender: UIButton) {
        performSegue(withIdentifier: "goToChangeEmail", sender: sender)
    }
    
    //Button to perform segue - to go Change password page
    @IBAction func goToChangePasswordPage(_ sender: UIButton) {
        performSegue(withIdentifier: "goToChangePassword", sender: sender)
    }
    
    //to perform segue - to go back menupage
    @IBAction func goToMenuPage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        self.userEmail.text = user?.email
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
