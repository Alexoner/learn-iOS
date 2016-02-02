//
//  CAViewController.swift
//  DemoCollection
//
//  Created by duhao.dh on 2/1/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class CAViewController: UIViewController {
    
    var segmentedControl: UISegmentedControl!
    var scrollView: UIScrollView!
    var redLayer: CALayer!
    var imageLayer: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        setupViews()
        setupLayers()
        setupAnimation()
    }
    
    func setupViews() {
        
        let items = ["corner", "path", "rotate", "affine"]
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: "changeAnimation:", forControlEvents: .ValueChanged)
        segmentedControl.sizeToFit()
        view.addSubview(segmentedControl)
        view.addConstraints([
            NSLayoutConstraint(item: segmentedControl, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 60),
            NSLayoutConstraint(item: segmentedControl, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: segmentedControl, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 40),
            NSLayoutConstraint(item: segmentedControl, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: -40),
            ])
        
        // Do any additional setup after loading the view.
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.backgroundColor = UIColor.purpleColor().CGColor
        scrollView.layer.cornerRadius = 5
        view.addSubview(scrollView)
        view.addConstraints([
            NSLayoutConstraint(item: scrollView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: segmentedControl, attribute: .Bottom, multiplier: 1.0, constant: 10),
            NSLayoutConstraint(item: scrollView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0),
            ])
        
        let size: CGSize = CGSize(width: 44, height: 44)
        let ballView:UIView = UIView()
        ballView.translatesAutoresizingMaskIntoConstraints = false
        ballView.backgroundColor = UIColor.redColor()
        //ballView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        ballView.layer.cornerRadius = 20
        ballView.layer.borderColor = UIColor.blueColor().CGColor
        scrollView.addSubview(ballView)
        scrollView.addConstraints([
            NSLayoutConstraint(item: ballView, attribute: .CenterY, relatedBy: .Equal, toItem: scrollView, attribute: .CenterY, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: ballView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: size.height),
            NSLayoutConstraint(item: ballView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: size.width),
            ])
        
    }
    
    func setupLayers() {
        // create a CALayer
        redLayer = CALayer()
        
        redLayer.frame = CGRect(x: 50, y: 0, width: 50, height: 50)
        redLayer.backgroundColor = UIColor.redColor().CGColor
        self.scrollView.layer.addSublayer(redLayer)
        
        // set content properties of CALayer
        imageLayer = CALayer()
        let image = UIImage(named: "ButterflySmall.jpg")!
        imageLayer.contents = image.CGImage
        
        imageLayer.frame = CGRect(x: 50, y:50, width: image.size.width, height: image.size.height)
        imageLayer.contentsGravity = kCAGravityResizeAspect
        imageLayer.contentsScale = UIScreen.mainScreen().scale
        
        self.scrollView.layer.addSublayer(imageLayer)
        
        // Corners and Border
        redLayer.cornerRadius = 25
        
        // set border
        redLayer.borderColor = UIColor.blackColor().CGColor
        redLayer.borderWidth = 10
        
        // drop shadow
        redLayer.shadowColor = UIColor.blackColor().CGColor
        redLayer.shadowOpacity = 0.8
        redLayer.shadowOffset = CGSizeMake(2, 2)
        redLayer.shadowRadius = 3
        
    }
    
    func setupAnimation() {
        // MARK: animations
        
        // Create a blank animation using the keyPath "cornerRadius", the property we want to animate
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        
        // Set the starting value
        animation.fromValue = redLayer.cornerRadius
        
        // Set the completion value
        animation.toValue = 0
        
        // How may times should the animation repeat?
        animation.repeatCount = 10
        
        // Finally, add the animation to the layer
        redLayer.addAnimation(animation, forKey: "cornerRadius")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: action handler
    /**
    Handler for when custom Segmented Control changes and will change the
    background color of the view depending on the selection.
    */
    func changeAnimation(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.backgroundColor = UIColor.brownColor()
        case 1:
            self.view.backgroundColor = UIColor.greenColor()
        case 2:
            self.view.backgroundColor = UIColor.blueColor()
        case 3:
            self.view.backgroundColor = UIColor.clearColor()
        default:
            self.view.backgroundColor = UIColor.purpleColor()
        }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
