//
//  SplashPageContentViewController.swift
//  Clother
//
//  Created by DSV on 2019-02-20.
//  Copyright © 2019 DSV. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PageContentViewController: UIViewController {
    var pageIndex: Int = 0
    var strPhotoName: String!
    @IBOutlet weak var splashImages: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //To display detail item images
        
        print(strPhotoName)
        /*Alamofire.request(strPhotoName!).responseImage { response in
            debugPrint(response)
            
            if let image = response.result.value {
                print(image)
               self.splashImages.image = image
            }
        }*/
        self.splashImages.image = UIImage(named: strPhotoName)
        
        // Do any additional setup after loading the view.
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
