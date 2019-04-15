//
//  AboutViewController.swift
//  Clother
//
//  Created by DSV on 2018-06-08.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    //Button to perform segue - to go menu page
    @IBAction func backToMenuPage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
