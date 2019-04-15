//
//  FinalViewController.swift
//  Clother
//
//  Created by DSV on 2018-05-23.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit
import Alamofire

class FinalViewController: UIViewController {
    //the Web API URL
    let URL_GET_DATA = "https://clother.azurewebsites.net/api/collections"
    
    //a list to store collections
    var collectionlists = [Collections]()
    
    //To perform segue for loading ItemViewController
    let itemSegueIdentifier = "exploreCollectionsSegue"
    
    // MARK: - Navigation  -  to pass collections to CollectionsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == itemSegueIdentifier,
            let destination = segue.destination as? MenuViewController
        {
            destination.collectionlists = collectionlists
        }
        //print(collectionlists[blogIndex].id!)
        //print("items")
        //print(collectionlists [blogIndex].itemurl!)
        
    }

    
    //Button to perform segue  - to go to Menu page
    @IBAction func exploreCollectionsButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "exploreCollectionsSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetching data from web api
        Alamofire.request(URL_GET_DATA).responseJSON { response in
            
            //getting json
            if let json = response.result.value {
                
                //converting json to NSArray
                let collectionArray : NSArray  = json as! NSArray
                
                //traversing through all elements of the array
                for i in 0..<collectionArray.count{
                    //adding values to the collection list
                    self.collectionlists.append(Collections(
                        id: (collectionArray[i] as AnyObject).value(forKey: "id") as? String,
                        name: (collectionArray[i] as AnyObject).value(forKey: "name") as? String,
                        imageUrl: (collectionArray[i] as AnyObject).value(forKey: "imageurl") as? String,
                        itemurl: (collectionArray[i] as AnyObject).value(forKey: "itemurl") as? String
                    ))
                }
                
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
