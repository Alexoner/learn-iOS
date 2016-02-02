//
//  ImageScrollViewController.swift
//  DemoCollection
//
//  Created by duhao.dh on 1/22/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

class ImageScrollViewController: UIViewController, UIScrollViewDelegate {

    // MARK: IBOutlets
    @IBOutlet var scrollView: UIScrollView!

    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadImageScroll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadImageScroll(){
        // 1
        let image = UIImage(named: "photo1.png")!
        imageView = UIImageView(image: image)
        imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size:image.size)
        scrollView.addSubview(imageView)

        // 2
        scrollView.contentSize = image.size

        // 3
        var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapRecognizer)

        // 4
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        scrollView.minimumZoomScale = minScale;

        // 5
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = minScale;

        // 6
        centerScrollViewFrame()
        centerScrollViewContents()

        // show the border
        scrollView.layer.cornerRadius = 8.0
        scrollView.layer.masksToBounds = true
        scrollView.layer.borderColor = UIColor.redColor().CGColor
        scrollView.layer.borderWidth = 1.0

    }

    
    func centerScrollViewFrame() {
        scrollView.frame.origin.x = (scrollView.superview!.bounds.width - scrollView.frame.size.width) / 2.0
        //scrollView.frame.origin.y = (scrollView.superview!.bounds.height - scrollView.frame.size.height) / 2.0
        
        //scrollView.bounds.origin.x = (scrollView.superview!.frame.width - scrollView.bounds.size.width) / 2.0
        scrollView.bounds.origin.y = (scrollView.superview!.frame.height - scrollView.bounds.size.height) / 2.0
    }

    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = imageView.frame

        print("scroll view size: ", scrollView.bounds.size, imageView.frame.size,scrollView.superview!.frame.size)
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }

        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }

        imageView.frame = contentsFrame
    }

    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        // 1
        let pointInView = recognizer.locationInView(imageView)

        // 2
        var newZoomScale = scrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)

        // 3
        let scrollViewSize = scrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)

        let rectToZoomTo = CGRectMake(x, y, w, h);

        // 4
        scrollView.zoomToRect(rectToZoomTo, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

    // MARK: UIScrollViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }




}
