//
//  InfoViewController.swift
//  Clother
//
//  Created by DSV on 2018-06-30.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit
import Firebase

class InfoViewController: UIViewController {
    
    @IBOutlet weak var `continue`: UIButton!
    //defining firebase reference var
    var refCustomers: DatabaseReference!
    
    //To know current User
    let user = Auth.auth().currentUser

    //variables that hold values for drop down menu
    var gender = ["Male","Female","Other","Prefer not to say"]
    var age = ["20-29","30-39","40-49","50-59","60-69","70-79","80+"]
    var country = ["Sweden","Other"]
    
    //drop down for age
    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var tblView: UITableView!
     //drop down for country
    @IBOutlet weak var btnDrop2: UIButton!
    @IBOutlet weak var tblView2: UITableView!
   
    //drop down for gender
    @IBOutlet weak var btnDrop3: UIButton!
    @IBOutlet weak var tblView3: UITableView!
    
    //Button to save details and perform segue to menu page
    @IBAction func showMenuPage(_ sender: UIButton) {
       /* //To check all entries are filled - alert
        if(btnDrop3.currentTitle == "Select Gender" || btnDrop.currentTitle == "Select Age" || btnDrop2.currentTitle == "Select Country")
        {
        let alert = UIAlertController(title: "Error", message: "Please Enter all details.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        self.present(alert, animated: true)
            }
        else  { */
        //To perform add customer detail to Firebase
        addCustomer()
        //To perform segue
        self.performSegue(withIdentifier: "fromInfoToMenuPage", sender: self)
               // }
    }
    
    //Function to add customer detail to firebase
    func addCustomer(){
        
        //generating a new key inside customers node and also getting the generated key
        let key = refCustomers.childByAutoId().key
       
        //creating customer with the given values
        let customer = ["id":key,
                     "customerEmail": user?.email ,
                      "customerGender": btnDrop3.currentTitle! as String,
                      "customerAge": btnDrop.currentTitle! as String,
                      "customerCountry": btnDrop2.currentTitle! as String
                        ]
        //print("customer",customer)
        
        //adding the customer inside the generated unique key
        refCustomers.child(key).setValue(customer)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        `continue`.layer.cornerRadius = 5
        //tableview is hidden initially
        tblView.isHidden = true
        tblView2.isHidden = true
        tblView3.isHidden = true
        
        //initialising firebase
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        //getting a reference to the node artists
        refCustomers = Database.database().reference().child("customers");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickDropButton(_ sender: Any) {
        if tblView.isHidden {
            animate(toogle: true, type: btnDrop)
        } else {
            animate(toogle: false, type: btnDrop)
        }
    }
    
    @IBAction func onClickDropButton2(_ sender: Any) {
        if tblView2.isHidden {
            animate(toogle: true, type: btnDrop2)
        } else {
            animate(toogle: false, type: btnDrop2)
        }
    }
    
    @IBAction func onClickDropButton3(_ sender: Any) {
        if tblView3.isHidden {
            animate(toogle: true, type: btnDrop3)
        } else {
            animate(toogle: false, type: btnDrop3)
        }
    }
    
    
    func animate(toogle: Bool, type: UIButton) {
        if type == btnDrop {
            if toogle {
                UIView.animate(withDuration: 0.3) {
                    self.tblView.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.tblView.isHidden = true
                }
            }
        } else if type == btnDrop2 {
            if toogle {
                UIView.animate(withDuration: 0.3) {
                    self.tblView2.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.tblView2.isHidden = true
                }
            }
        }
        else {
            if toogle {
                UIView.animate(withDuration: 0.3) {
                    self.tblView3.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.tblView3.isHidden = true
                }
            }
        }
    }
    
    
}

extension  InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView==tblView
        { return age.count
             }
        else if tableView==tblView2
            {
        return country.count
                 }
        else
        {
            return gender.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView==tblView
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = age[indexPath.row]
        return cell
        }
        else  if tableView==tblView2
         {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            cell.textLabel?.text = country[indexPath.row]
            return cell
             }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
            cell.textLabel?.text = gender[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView==tblView
         {
        btnDrop.setTitle("\(age[indexPath.row])", for: .normal)
        animate(toogle: false, type: btnDrop)
             }
        else if tableView==tblView2
        {
            btnDrop2.setTitle("\(country[indexPath.row])", for: .normal)
            animate(toogle: false, type: btnDrop2)
        }
        else
        {
            btnDrop3.setTitle("\(gender[indexPath.row])", for: .normal)
            animate(toogle: false, type: btnDrop3)
        }
    }
}


