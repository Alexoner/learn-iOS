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
    let items = ["corner", "path", "keyframe", "rotate", "affine", "group", "opacity", ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        setupViews()
        setupLayers()
        setupAnimation(items[0])
    }
    
    func setupViews() {
        
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: "changeAnimation:", forControlEvents: .ValueChanged)
        segmentedControl.sizeToFit()
        view.addSubview(segmentedControl)
        //view.insertSubview(segmentedControl, belowSubview: self.navigationController!.view)
        print ("self.navigationController!.view.frame.height", self.navigationController?.navigationBar.frame.height)
        view.addConstraints([
            NSLayoutConstraint(item: segmentedControl, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 20 + (self.navigationController?.navigationBar.frame.height)!),
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
        //self.scrollView.layer.addSublayer(redLayer)
        
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
        
        self.scrollView.layer.addSublayer(redLayer)
        
    }
    
    func setupAnimation(type: String!) {
        // MARK: animations
        switch(type) {
        case "corner":
            setupAnimationCorner()
            break
        case "opacity":
            setupAnimationOpacity()
            break
        case "keyframe":
            setupAnimationKeyframe()
            break
        case "group":
            setupAnimationGroup()
            break
        default:
            setupAnimationCorner()
            break
            
        }
    }
    
    func setupAnimationCorner() {
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
    
    func setupAnimationOpacity() {
        let fadeAnim = CABasicAnimation(keyPath: "opacity")
        fadeAnim.fromValue = 1.0;
        fadeAnim.toValue = 0.0;
        fadeAnim.duration = 3.0;
        
        redLayer.addAnimation(fadeAnim, forKey: "opacity")
    }
    
    func setupAnimationKeyframe() {
        // create a CGPath that implements two arcs ( a bounce)
        let path:CGMutablePathRef = CGPathCreateMutable()
        CGPathMoveToPoint(path , nil, 74.0, 74.0)
        CGPathAddCurveToPoint(path, nil,
            74.0, 500.0,
            320.0, 500.0,
            320.0, 74.0)
        CGPathAddCurveToPoint(path,nil,320.0,500.0,
            566.0,500.0,
            566.0,74.0)
        
        // create the animation object, specifying the position property as the key path.
        let keyframeAnim: CAKeyframeAnimation  = CAKeyframeAnimation(keyPath: "position")
        keyframeAnim.path = path
        keyframeAnim.duration = 5.0
        
        // add the animation
        redLayer.addAnimation(keyframeAnim, forKey: "position")
    }
    
    func setupAnimationGroup() {
        // Animation 1
        var widthAnim: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "borderWidth")
        var widthValues: [AnyObject] = [1.0, 10.0, 5.0, 30.0, 0.5, 15.0, 2.0, 50.0, 0.0]
        widthAnim.values = widthValues
        widthAnim.calculationMode = kCAAnimationPaced
        // Animation 2
        var colorAnim: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "borderColor")
        var colorValues: [AnyObject] = [UIColor.greenColor().CGColor as! AnyObject, UIColor.redColor().CGColor as! AnyObject, UIColor.blueColor().CGColor as! AnyObject]
        colorAnim.values = colorValues
        colorAnim.calculationMode = kCAAnimationPaced
        // Animation group
        var group: CAAnimationGroup = CAAnimationGroup()
        group.animations = [colorAnim, widthAnim]
        group.duration = 5.0
        redLayer.addAnimation(group, forKey: "BorderChanges")
        setupAnimationKeyframe()

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
        setupAnimation(items[sender.selectedSegmentIndex])
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
