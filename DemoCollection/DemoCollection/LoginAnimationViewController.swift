//
//  LoginAnimationViewController.swift
//  DemoCollection
//
//  Created by duhao.dh on 2/1/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class LoginAnimationViewController: UIViewController {
    
    
    // MARK: IB outlets
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var heading: UILabel!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var cloud1: UIImageView!
    @IBOutlet var cloud2: UIImageView!
    @IBOutlet var cloud3: UIImageView!
    @IBOutlet var cloud4: UIImageView!
    
    
    // MARK: further UI
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    
    
    // MARK: view controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up the UI
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(spinner)
        
        status.hidden = true
        status.center = loginButton.center
        view.addSubview(status)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .Center
        status.addSubview(label)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // move each of the form elements outside the visible bounds of the screen
        heading.center.x -= view.bounds.width
        username.center.x -= view.bounds.width
        password.center.x -= 1.0/2 * view.bounds.width
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.5, animations: {
            self.heading.center.x += self.view.bounds.width
            // self.username.center.x += self.view.bounds.width
        })
        // delayed animation
        UIView.animateWithDuration(0.5, delay: 0.3, options:[], animations:{
            self.username.center.x += self.view.bounds.width
            }, completion: nil)
        // animation options
        UIView.animateWithDuration(0.5, delay: 0.4, options: [.Repeat, .Autoreverse, .CurveEaseInOut],
            animations: {
                self.password.center.x += 1.0/2 * self.view.bounds.width
            }, completion: nil)
        
        // animation easing
    }
    
    // MARK: further methods
    
    @IBAction func login() {
        
    }
}
