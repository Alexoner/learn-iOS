//
//  TimeLineViewController.swift
//  DemoCollection
//
//  Created by duhao.dh on 1/25/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

class TimeLineViewController: UIViewController, UIScrollViewDelegate {

    var scrollView: UIScrollView!
    var timeline:   TimelineView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        view.addSubview(scrollView)

        view.addConstraints([
            NSLayoutConstraint(item: scrollView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 29),
            NSLayoutConstraint(item: scrollView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0)
            ])

        let timeFrames = [
            TimeFrame(text: "New Year's Day", date: "January 1", image: UIImage(named: "fireworks.jpeg")),
            TimeFrame(text: "The month of love!", date: "February 14", image: UIImage(named: "heart.png")),
            TimeFrame(text: "Comes like a lion, leaves like a lamb", date: "March",  image: nil),
            TimeFrame(text: "Dumb stupid pranks.\nGame of Thrones", date: "April 1", image: UIImage(named: "april.jpeg")),
            TimeFrame(text: "That's right. No image is necessary!", date: "No image?", image: nil),
            TimeFrame(text: "This control can stretch. It doesn't matter how long or short the text is, or how many times you wiggle your nose and make a wish. The control always fits the content, and even extends a while at the end so the scroll view it is put into, even when pulled pretty far down, does not show the end of the scroll view.", date: "Long text", image: nil),
            TimeFrame(text: "Hope this helps someone!", date: "That's it!", image: nil)
            ]

        timeline = TimelineView(bulletType: BulletType.Circle, timeFrames: timeFrames)
        scrollView.addSubview(timeline)
        scrollView.addConstraints([
            NSLayoutConstraint(item: timeline, attribute: .Left, relatedBy: .Equal, toItem: scrollView, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Bottom, relatedBy: .LessThanOrEqual, toItem: scrollView, attribute: .Bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Top, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Right, relatedBy: .Equal, toItem: scrollView, attribute: .Right, multiplier: 1.0, constant: 0),
            
            NSLayoutConstraint(item: timeline, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1.0, constant: 0)
            ])
        timeline.lineColor = UIColor(red: 104/255, green: 236/255, blue: 206/255, alpha: 1.0)
        
        view.sendSubviewToBack(scrollView)
    }
    
    @IBAction func bulletChanged(sender: UISegmentedControl) {
        timeline.lineColor = UIColor(red: 104/255, green: 236/255, blue: 206/255, alpha: 1.0)
        timeline.bulletType = [BulletType.Circle, BulletType.Hexagon, BulletType.Diamond, BulletType.DiamondSlash, BulletType.Carrot, BulletType.Arrow][sender.selectedSegmentIndex]
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //
        print("scrolled view!", timeline.frame.size, scrollView.contentOffset)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
