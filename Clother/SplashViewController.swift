//
//  SplashViewController.swift
//  Clother
//
//  Created by DSV on 2019-02-25.
//  Copyright © 2019 DSV. All rights reserved.
//
import UIKit
class SplashViewController: UIViewController, UIGestureRecognizerDelegate
{
    var index: Int = 0;
    @IBOutlet weak var describelabel: UILabel!
    @IBOutlet weak var splashbackground: UIView!
    @IBOutlet weak var splashImages: UIImageView!
    
    @IBOutlet weak var Login: UIButton!
    
    @IBOutlet weak var Create: UIButton!
    
    @IBOutlet weak var Guest: UIButton!
    
    //Login Button - Segue to connect Login Page
    @IBAction func login(_ sender: UIButton) {
        self.performSegue(withIdentifier: "login", sender: self)
    }
    
    //Create Button - Segue to connect Create page
    @IBAction func create(_ sender: UIButton) {
        self.performSegue(withIdentifier: "create", sender: self)
    }
    @IBAction func guest(_ sender: UIButton) {
        if Connectivity.isConnectedToInternet() {
            // print("Yes! internet is available.")
        self.performSegue(withIdentifier: "guest", sender: self)
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

    
    
    
    //Array for item images
    var arrPagePhoto = [String]()
    //For page dots
    var pageControl = UIPageControl()
    //Gestures:  swipe to view all splash images
    var swipeGesture  = UISwipeGestureRecognizer()
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        //pageControl = UIPageControl(frame: CGRect(x: frame.size.width - (frame.size.width + 20), y: frame.size.height - (frame.size.height + 20), width: 100, height: 100))
       // pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 260,width: UIScreen.main.bounds.width,height: 50))
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - ( (UIScreen.main.bounds.maxY / 2) - 90),width: UIScreen.main.bounds.width,height: 50))
        pageControl.transform = CGAffineTransform(scaleX: 2, y: 2)
        self.pageControl.numberOfPages = arrPagePhoto.count
        self.pageControl.currentPage = 0
        describelabel.text = "Bring your ideas into our design process! You decide what to be produced!"
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.red
        
        
        self.view.addSubview(pageControl)
    }
    
    // To perform swipe for detail images
    
    @objc func swipeImage(_ gestureRecognizer: UISwipeGestureRecognizer) {
        //var index=0;
        if gestureRecognizer.direction == .left{
            index += 1
            if index > arrPagePhoto.count - 1 {
                index = 0  }
                pageControl.currentPage = index
                self.splashImages.image = UIImage(named: arrPagePhoto[index])
               // setupView(at: arrPagePhoto[index])
            
                   // print("swipe left")
                   // print("image at index",arrPagePhoto[index])
                    //print("page",pageControl.currentPage )
            
            // to set label
            if(pageControl.currentPage==0)
            {
                describelabel.text = "Bring your ideas into our design process! You decide what to be produced!"
            }
            else if (pageControl.currentPage==1)
            {
                describelabel.text = "Review the upcoming collections and tell us what you like!"
            }
            else if (pageControl.currentPage==2)
            {
                describelabel.text = "Step ahead of the trend and become the fashion influencer today!"
            }
           
        }
        else if gestureRecognizer.direction == .right{
            index -= 1
            if index < 0 {
                index = arrPagePhoto.count - 1   }
            
                self.splashImages.image = UIImage(named: arrPagePhoto[index])
                //setupView(at: arrPagePhoto[index])
                
                pageControl.currentPage = index
           // print("swipe right")
            //print(arrPagePhoto[index])
                //print("page",pageControl.currentPage )
            //to set label
            if(pageControl.currentPage==0)
            {
                describelabel.text = "Bring your ideas into our design process! You decide what to be produced!"
            }
            else if (pageControl.currentPage==1)
            {
                describelabel.text = "Review the upcoming collections and tell us what you like!"
            }
            else if (pageControl.currentPage==2)
            {
                describelabel.text = "Step ahead of the trend and become the fashion influencer today!"
            }
          
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        arrPagePhoto = ["splash 1.png", "splash 2.png", "splash 3.png"];
        describelabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        // To perform swipe for detail images
        swipeGesture.delegate = self
        self.splashImages.image = UIImage(named: arrPagePhoto[0])
        let directions: [UISwipeGestureRecognizerDirection] = [ .right, .left]
        for direction in directions {
            swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeImage(_:)))
          splashbackground.addGestureRecognizer(swipeGesture)
            swipeGesture.direction = direction
           splashbackground.isUserInteractionEnabled = true
            splashbackground.isMultipleTouchEnabled = true
        }
        //page dots
        //self.delegate = self
        configurePageControl()
        //addSubview(pageControl)
         }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
