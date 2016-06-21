//
//  PhotoViewController.swift
//  FacebookDemo
//
//  Created by Scott Horsfall on 6/18/16.
//  Copyright © 2016 Scott Horsfall. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var image: UIImage!

    @IBOutlet weak var photoActionsView: UIImageView!
    @IBOutlet weak var doneButton: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
        
        scrollView.contentSize = CGSize(width: 320, height: 600)
        scrollView.delegate = self
        
        photoActionsView.alpha = 1
        doneButton.alpha = 1
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDoneTap(sender: AnyObject) {
        
        dismissViewControllerAnimated(true) { 
            // dismiss
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // This method is called as the user scrolls
        
        let translation = scrollView.contentOffset
        let alpha = convertValue(CGFloat(translation.y), r1Min: 0, r1Max: -100, r2Min: 1, r2Max: 0)
        
        scrollView.backgroundColor = UIColor(white: 0, alpha: alpha)

    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        UIView.animateWithDuration(0.3) { 
            self.photoActionsView.alpha = 0
            self.doneButton.alpha = 0
        }
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,
                                  willDecelerate decelerate: Bool) {
        
        if scrollView.contentOffset.y > 100 || scrollView.contentOffset.y < -100 {
            
            scrollView.alpha = 0

            dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            UIView.animateWithDuration(0.3, animations: { 
                self.photoActionsView.alpha = 1
                self.doneButton.alpha = 1
            })
        }

    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }


}
