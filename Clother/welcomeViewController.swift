//
//  welcomeViewController.swift
//  Clother
//
//  Created by DSV on 2018-07-02.
//  Copyright © 2018 DSV. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class welcomeViewController: UIViewController {
    //the Web API URL
    let URL_GET_DATA = "https://clother.azurewebsites.net/api/collections"
    
    //a list to store collections
    var collectionlists = [Collections]()
    
    //To perform segue for loading ItemViewController
    let itemSegueIdentifier = "welcomeSeguetoMenu"
    
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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func start()
    {
    activityIndicator.startAnimating()
    }
    func stop()
     {
        activityIndicator.stopAnimating()
    }
    override func viewDidLoad() {
        view.addSubview(activityIndicator  )
        activityIndicator.center = view.center;
        
        super.viewDidLoad()
        //Display welcome page for 2 sec
        start()
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
                    print(i,collectionArray[i])
                }
                
            }
        }
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
            self.performSegue(withIdentifier: "welcomeSeguetoMenu", sender: self)
            
       })
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
