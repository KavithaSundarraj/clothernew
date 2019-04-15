//
//  ViewController.swift
//  Clother
//
//  Created by DSV on 2018-04-16.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //Login Button - Segue to connect Login Page
    @IBAction func goToLogInPage(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToLogIn", sender: self)
    }
    
    //Create Button - Segue to connect Create page
    @IBAction func goToCreatePage(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToCreate", sender: self)
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

