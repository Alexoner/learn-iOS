//
//  PagedTimeLineViewController.swift
//  DemoCollection
//
//  Created by duhao.dh on 2/22/16.
//  Copyright © 2016 None. All rights reserved.
//

import Foundation
import UIKit

class PagedTimeLineViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var timeline:   TimelineView!
    var timelines: [TimelineView]!
    var currentPage: Int! = -1
    var nextPage: Int! = -1
    var lastContentOffset: CGPoint! = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timelines = [TimelineView]()
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        // a page is the width of scroll view?
        scrollView.pagingEnabled = false

        view.addSubview(scrollView)
        
        view.addConstraints([
            NSLayoutConstraint(item: scrollView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 30),
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
            NSLayoutConstraint(item: timeline, attribute: .Right, relatedBy: .Equal, toItem: scrollView, attribute: .Right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Top, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Bottom, relatedBy: .LessThanOrEqual, toItem: scrollView, attribute: .Bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1.0, constant: 0),
            //NSLayoutConstraint(item: timeline, attribute: .Height, relatedBy: .GreaterThanOrEqual, toItem: scrollView, attribute: .Height, multiplier: 1.0, constant: 0),
            ])
        timeline.lineColor = UIColor(red: 104/255, green: 236/255, blue: 206/255, alpha: 1.0)
        timelines.append(timeline)
        currentPage = 0
        
        // the second timeline page
        let timeFrames2 = [
            TimeFrame(text: "New Year's Day", date: "January 1", image: UIImage(named: "fireworks.jpeg")),
            TimeFrame(text: "The month of love!", date: "February 14", image: UIImage(named: "heart.png")),
            TimeFrame(text: "Comes like a lion, leaves like a lamb", date: "March",  image: nil),
        ]
        
        let timeline2 = TimelineView(bulletType: BulletType.Circle, timeFrames: timeFrames2)
        scrollView.addSubview(timeline2)
        scrollView.addConstraints([
            NSLayoutConstraint(item: timeline2, attribute: .Left, relatedBy: .Equal, toItem: scrollView, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline2, attribute: .Right, relatedBy: .Equal, toItem: scrollView, attribute: .Right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline2, attribute: .Top, relatedBy: .Equal, toItem: timelines[0], attribute: .Bottom, multiplier: 1.0, constant: 30),
            NSLayoutConstraint(item: timeline2, attribute: .Bottom, relatedBy: .LessThanOrEqual, toItem: scrollView, attribute: .Bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline2, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1.0, constant: 0),
            //NSLayoutConstraint(item: timeline2, attribute: .Height, relatedBy: .GreaterThanOrEqual, toItem: scrollView, attribute: .Height, multiplier: 1.0, constant: 0),
            ])
        timeline2.lineColor = UIColor(red: 255/255, green: 236/255, blue: 206/255, alpha: 1.0)
        timelines.append(timeline2)
        
        
        view.sendSubviewToBack(scrollView)
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //
        if lastContentOffset.y < scrollView.contentOffset.y {
            nextPage = currentPage + 1
            print("scrolled up, next page is: ", nextPage, scrollView.tracking)
        } else {
            nextPage = currentPage - 1
            print("scrolled down, next page is: ", nextPage, scrollView.tracking)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //
    }
    
    // at the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        //
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //
        print("ended dragging", scrollView.tracking)
        // actually not used here
        if scrollView.tracking == true {
            // return
        }
        
        lastContentOffset = scrollView.contentOffset
        
        if nextPage < 0 || nextPage > timelines.count - 1 {
            return
        }
        let position: CGRect = timelines[nextPage].frame
        //let area: CGRect = CGRectMake(scrollView.contentOffset.x, scrollView.contentOffset.y, scrollView.frame.size.width, scrollView.frame.size.height)
        
        if( CGRectIntersectsRect(position, scrollView.bounds)){
            print("next page is visible!!!yeah yeah yeah", nextPage)
            currentPage = nextPage
            scrollView.setContentOffset(CGPoint(x: 0, y: timelines[currentPage].frame.origin.y), animated: true)
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
