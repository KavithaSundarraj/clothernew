//
//  TinderCard.swift
//  Clother
//
//  Created by DSV on 2018-05-16.
//  Copyright © 2018 DSV. All rights reserved.
//

let ACTION_MARGIN = (UIScreen.main.bounds.size.width/2) * 0.75
let SCALE_STRENGTH : CGFloat = 4
let SCALE_MAX : CGFloat = 0.93
let ROTATION_STRENGTH = UIScreen.main.bounds.size.width

import UIKit
import Alamofire
import AlamofireImage

protocol TinderCardDelegate: NSObjectProtocol {
    func cardSwipedLeft(_ card: TinderCard)
    func cardSwipedRight(_ card: TinderCard)
    func updateCardView(_ card: TinderCard, withDistance distance: CGFloat)
}

class TinderCard: UIView, UIGestureRecognizerDelegate {
    
    var xFromCenter: CGFloat = 0.0
    var yFromCenter: CGFloat = 0.0
    var originalPoint = CGPoint.zero
    var index : Int = 0;
    
    //image view for like-button and Unlike-button to show
    var imageViewStatus = UIImageView()
    
    //image view for green and red image for like and unlike
    var overLayImage = UIImageView()
    
    //Array for item images
    var arrPagePhoto = [String]()
    
    //Gestures: pan for tinder and swipe to view all images
    var panGestureRecognizer = UIPanGestureRecognizer()
    var swipeGesture  = UISwipeGestureRecognizer()
    var tapGesture = UITapGestureRecognizer()
    
    //For page dots
    var pageControl = UIPageControl()
    
    var isLiked = false
    weak var delegate: TinderCardDelegate?
    
    //Counter for likes and Dislikes
    var likes = Int()
    var dislikes = Int()
    
    
    
    //To post likes to url
    // variable to store parameter
    var itemid = String()
    var review = Bool()
    let url = "https://clother.azurewebsites.net/newitem/review/"
    
    //method called first from collectionViewController
    public init(frame: CGRect, value: items) {
        super.init(frame: frame)
        arrPagePhoto = value.itemDetailImagesUrl!
        likes = value.likes!
        dislikes = value.dislikes!
        itemid = value.itemId!
        setupView(at: value.itemUrl!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //method called inside init - to set images in background
    func setupView(at value:String) {
        
        layer.cornerRadius = 10
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0.5, height: 3)
        layer.shadowColor = UIColor.darkGray.cgColor
        clipsToBounds = true
        isUserInteractionEnabled = false
        
        originalPoint = center
        
        if(arrPagePhoto.count>0)
        {
            //Tap left and right to see detail image
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(singleTapped))
            tapGesture.numberOfTapsRequired = 1
            addGestureRecognizer(tapGesture)
            isUserInteractionEnabled = true
            isMultipleTouchEnabled = true
        
     /*   // To perform swipe for detail images
        swipeGesture.delegate = self
        let directions: [UISwipeGestureRecognizerDirection] = [ .up, .down]
        for direction in directions {
            swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeImage(_:)))
            addGestureRecognizer(swipeGesture)
            swipeGesture.direction = direction
 
          isUserInteractionEnabled = true
          isMultipleTouchEnabled = true
        }
            */
            
        }
        
       panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.beingDragged))
        addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.delegate=self
   
        
    //To display Collection items from url to image
        let backGroundImageView = UIImageView(frame:bounds)
      backGroundImageView.contentMode = UIViewContentMode.scaleAspectFit
        let Url = value
        print("durl",Url)
        Alamofire.request(Url).responseImage { response in
            debugPrint(response)
            if let image = response.result.value {
                backGroundImageView.backgroundColor = UIColor.white
                backGroundImageView.image = image
                }
            }

        
        backGroundImageView.clipsToBounds = true;
        addSubview(backGroundImageView)

        imageViewStatus = UIImageView(frame: CGRect(x: (frame.size.width / 2) - 37.5, y:frame.size.height / 2, width: 75, height: 75))
        imageViewStatus.alpha = 0
        addSubview(imageViewStatus)
        
        overLayImage = UIImageView(frame:bounds)
        overLayImage.alpha = 0
        addSubview(overLayImage)
        
         //page dots
        if(arrPagePhoto.count>0)
        {
        configurePageControl()
        addSubview(pageControl)
        }
        
       
    }
   
    //Function for SingleTap the UIview to open to load items images
    @objc func singleTapped(touch: UITapGestureRecognizer) {
        // do something here
        
        let touchPoint = touch.location(in: self)
        if touchPoint.x > (frame.size.width / 2 )
        {
            index += 1
            if index >= arrPagePhoto.count  {
                index -= 1 }
            else
            {
                print("image at index",arrPagePhoto[index])
                setupView(at: arrPagePhoto[index])
                pageControl.currentPage = index
                print("page",pageControl.currentPage ) }
            
        }else
        {
            index -= 1
            if index  < 0 {
                index += 1 }
            else
            {
                print(arrPagePhoto[index])
                setupView(at: arrPagePhoto[index])
                pageControl.currentPage = index
                print("page",pageControl.currentPage )
                
             }
        }
    }
    /*
    //UIGestureDelegate method
    //Delaying the recognition of a pan gesture until after a swipe fails
   
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                             shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGestureRecognizer &&
            otherGestureRecognizer == self.swipeGesture {
              print("inside shouldRequireFailureOf false")
            return false
        }
        print("inside shouldRequireFailureOf true")
        return true
    }
    
    
    // To perform swipe for detail images
  
    @objc func swipeImage(_ gestureRecognizer: UISwipeGestureRecognizer) {
          var index=0;
        if gestureRecognizer.direction == .down {
            index += 1
            if index >= arrPagePhoto.count - 1 {
                index = 0
                 print("image at index",arrPagePhoto[index])
                setupView(at: arrPagePhoto[index])
                pageControl.currentPage = index
                print("page",pageControl.currentPage )
            }
               }
            else if gestureRecognizer.direction == .up {
                index -= 1
                if index < 0 {
                    index = arrPagePhoto.count - 1
                     print(arrPagePhoto[index])
                    setupView(at: arrPagePhoto[index])
                    pageControl.currentPage = index
                    print("page",pageControl.currentPage )
                }
        }
        }
    //
    */
    
   // To perform tinder
    @objc func beingDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
    
        xFromCenter = gestureRecognizer.translation(in: self).x
        yFromCenter = gestureRecognizer.translation(in: self).y
        switch gestureRecognizer.state {
        // Keep swiping
        case .began:
            originalPoint = self.center;
            break;
            
        //in the middle of a swipe
        case .changed:
            print("inside")
            let rotationStrength = min(xFromCenter / ROTATION_STRENGTH, 1)
            let rotationAngel = .pi/8 * rotationStrength
            let scale = max(1 - fabs(rotationStrength) / SCALE_STRENGTH, SCALE_MAX)
            center = CGPoint(x: originalPoint.x + xFromCenter, y: originalPoint.y + yFromCenter)
            let transforms = CGAffineTransform(rotationAngle: rotationAngel)
            let scaleTransform: CGAffineTransform = transforms.scaledBy(x: scale, y: scale)
            
            self.transform = scaleTransform
            updateOverlay(xFromCenter)
            break;
        // swipe ended
        case .ended:
            afterSwipeAction()
            break;
            
        case .possible:break
        case .cancelled:break
        case .failed:break
        }
    }
    
    //Function to configure PageDots
    func configurePageControl() {
        // The total number of pages that are available is based on how many detailed item images we have.
        // w355 h440   =  370   480 iphone8
        // w300 h341 =  320 380    iphone5s
        //w355 h420 =   370 460 iphone6
        //w394 h509 =  414 549 iphone6plus
        
       //  pageControl = UIPageControl(frame: CGRect(x: frame.size.width - (frame.size.width + 20), y: frame.size.height - (frame.size.height + 20), width: 100, height: 100))
        pageControl = UIPageControl(frame: CGRect(x: (frame.size.width / 2) - 50, y: (frame.size.height/2) - (frame.size.height/3) - 85, width: 100, height: 100))
        // print("frame width=",frame.size.width,"frame height=",frame.size.height)
        //pageControl.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2));
            pageControl.numberOfPages = arrPagePhoto.count
            pageControl.currentPage = 0
            pageControl.tintColor = UIColor.black
            pageControl.pageIndicatorTintColor = UIColor.lightGray
            pageControl.currentPageIndicatorTintColor = UIColor.red
            addSubview(pageControl)
    }
    
    
    //Function to display like and unlike outer screens
    func updateOverlay(_ distance: CGFloat) {
        
        imageViewStatus.image = distance > 0 ? UIImage(named: "yesButton") : UIImage(named: "noButton")
        overLayImage.image = distance > 0 ? UIImage(named: "overlay_skip") : UIImage(named: "overlay_skip")
        imageViewStatus.alpha = min(fabs(distance) / 100, 0.5)
        overLayImage.alpha = min(fabs(distance) / 100, 0.5)
        delegate?.updateCardView(self, withDistance: distance)
    }
    
   //Function to perform after pan gesture swipe
    func afterSwipeAction() {
        if xFromCenter > ACTION_MARGIN {
            rightAction()
        }
        else if xFromCenter < -ACTION_MARGIN {
            leftAction()
        }
        else {
            //reseting image
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: [], animations: {
                self.center = self.originalPoint
                self.transform = CGAffineTransform(rotationAngle: 0)
                self.imageViewStatus.alpha = 0
                self.overLayImage.alpha = 0
            })
        }
    }
    
    //right action
    func rightAction() {
        let finishPoint = CGPoint(x: frame.size.width*2, y: 2 * yFromCenter + originalPoint.y)
        UIView.animate(withDuration: 0.5, animations: {
            self.center = finishPoint
        }, completion: {(_) in
            self.removeFromSuperview()
        })
        isLiked = true
        delegate?.cardSwipedRight(self)
        print("WATCHOUT RIGHT")
        // To make update of items likes and dislikes in json
        likes = likes + 1
        print("likes", likes)
        review = true
       // ----------
        //To hit url - to post likes
        
        let parameters = [
            "id": itemid,
            "review": review
            ] as [String : Any]
        Alamofire.request(url, method:.post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print(response)
            case .failure(let error):
                print(error)
            }
            //-------
        }
        
        
    }
    
    // left action
    func leftAction() {
        
        let finishPoint = CGPoint(x: -frame.size.width*2, y: 2 * yFromCenter + originalPoint.y)
        UIView.animate(withDuration: 0.5, animations: {
            self.center = finishPoint
        }, completion: {(_) in
            self.removeFromSuperview()
        })
        isLiked = false
        delegate?.cardSwipedLeft(self)
        print("WATCHOUT LEFT")
        dislikes = dislikes + 1
        print("dislikes", dislikes)
        review = false
        // ----------
        //To hit url - to post likes
        
        let parameters = [
            "id": itemid,
            "review": review
            ] as [String : Any]
        Alamofire.request(url, method:.post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print(response)
            case .failure(let error):
                print(error)
            }
             }
            //-------
        
    }
    
    // right click action
    func rightClickAction() {
        imageViewStatus.image = UIImage(named: "yesButton")
        overLayImage.image = UIImage(named: "overlay_skip" )
        let finishPoint = CGPoint(x: center.x + frame.size.width * 2, y: center.y)
        imageViewStatus.alpha = 0.5
        overLayImage.alpha = 0.5
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
            self.center = finishPoint
            self.transform = CGAffineTransform(rotationAngle: 1)
            self.imageViewStatus.alpha = 1.0
            self.overLayImage.alpha = 1.0
        }, completion: {(_ complete: Bool) -> Void in
            self.removeFromSuperview()
        })
        isLiked = true
        delegate?.cardSwipedRight(self)
        print("WATCHOUT RIGHT ACTION")
        likes = likes + 1
        print("likes", likes)
        review = true
        // ----------
        //To hit url - to post likes
    
        let parameters = [
            "id": itemid,
            "review": review
            ] as [String : Any]
        Alamofire.request(url, method:.post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print(response)
            case .failure(let error):
                print(error)
            }
             }
            //-------
    }
    
    // left click action
    func leftClickAction() {
        imageViewStatus.image = UIImage(named: "noButton")
        overLayImage.image = UIImage(named:"overlay_skip")
        let finishPoint = CGPoint(x: center.x - frame.size.width * 2, y: center.y)
        imageViewStatus.alpha = 0.5
        overLayImage.alpha = 0.5
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
            self.center = finishPoint
            self.transform = CGAffineTransform(rotationAngle: -1)
            self.imageViewStatus.alpha = 1.0
            self.overLayImage.alpha = 1.0
        }, completion: {(_ complete: Bool) -> Void in
            self.removeFromSuperview()
        })
        isLiked = false
        delegate?.cardSwipedLeft(self)
        print("WATCHOUT LEFT ACTION")
        dislikes = dislikes + 1
        print("dislikes", dislikes)
        review = false
        // ----------
        //To hit url - to post likes
        
        let parameters = [
            "id": itemid,
            "review": review
            ] as [String : Any]
        Alamofire.request(url, method:.post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                print(response)
            case .failure(let error):
                print(error)
            }
             }
            //-------
    }
    
    func discardCard(){
        UIView.animate(withDuration: 0.5) {
            self.removeFromSuperview()
        }
    }
    
    func shakeCard()
    {
        imageViewStatus.image = UIImage(named: "noButton")
        overLayImage.image = UIImage(named: "overlay_skip")
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            self.center = CGPoint(x: self.center.x - (self.frame.size.width / 2), y: self.center.y)
            self.transform = CGAffineTransform(rotationAngle: -0.2)
            self.imageViewStatus.alpha = 1.0
            self.overLayImage.alpha = 1.0
        }, completion: {(_ complete: Bool) -> Void in
            UIView.animate(withDuration: 0.5, animations: {() -> Void in
                self.imageViewStatus.alpha = 0
                self.overLayImage.alpha = 0
                self.center = self.originalPoint
                self.transform = CGAffineTransform(rotationAngle: 0)
            }, completion: {(_ complete: Bool) -> Void in
                self.imageViewStatus.image = UIImage(named: "yesButton")
                self.overLayImage.image =  UIImage(named: "overlay_skip")
                UIView.animate(withDuration: 0.5, animations: {() -> Void in
                    self.imageViewStatus.alpha = 1
                    self.overLayImage.alpha = 1
                    self.center = CGPoint(x: self.center.x + (self.frame.size.width / 2), y: self.center.y)
                    self.transform = CGAffineTransform(rotationAngle: 0.2)
                }, completion: {(_ complete: Bool) -> Void in
                    UIView.animate(withDuration: 0.5, animations: {() -> Void in
                        self.imageViewStatus.alpha = 0
                        self.overLayImage.alpha = 0
                        self.center = self.originalPoint
                        self.transform = CGAffineTransform(rotationAngle: 0)
                    })
                })
            })
        })
        
        print("WATCHOUT SHAKE ACTION")
    }
}

