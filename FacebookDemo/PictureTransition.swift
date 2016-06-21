//
//  PictureTransition.swift
//  transitionDemo
//
//  Created by Scott Horsfall on 06/18/16.
//  Copyright (c) 2016 Scott Horsfall. All rights reserved.
//

import UIKit

class PictureTransition: BaseTransition {
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let tabViewController = fromViewController as! UITabBarController
        let feedViewController = tabViewController.selectedViewController as! FeedViewController
        let photoViewController = toViewController as! PhotoViewController
        
        let tempImageView = UIImageView()
        
        // get the tempImage frame x, y and scrollview Y frame
        let tempImageFrameX = feedViewController.selectedImageView.frame.minX
        let tempImageFrameY = feedViewController.selectedImageView.frame.minY
        let scrollViewFrameY = feedViewController.scrollView.frame.minY
        
        // doesn't account for when the scrollview has scrolled, would subtract that in the Y here
        let tempImagePoint = CGPoint(x: tempImageFrameX, y: tempImageFrameY + scrollViewFrameY)
        let tempImageFrame = CGRect(origin: tempImagePoint, size: feedViewController.selectedImageView.frame.size)
        
        // setup the temp image
        tempImageView.frame = tempImageFrame
        tempImageView.image = feedViewController.selectedImageView.image
        tempImageView.contentMode = feedViewController.selectedImageView.contentMode
        
        // hide image in feedView and add temp image to animation container view
        feedViewController.selectedImageView.hidden = true
        containerView.addSubview(tempImageView)
        
        // hide the photoView and image there until complete
        photoViewController.view.alpha = 0
        photoViewController.imageView.hidden = true
        
        UIView.animateWithDuration(duration, animations: {
            photoViewController.view.alpha = 1
            
            // aspect ratio
            let aspectRatio = tempImageView.image!.size.width / tempImageView.image!.size.height
            
            // respect frame + ratio
            tempImageView.frame.size.width = photoViewController.imageView.frame.size.width
            tempImageView.frame.size.height = tempImageView.frame.size.width / aspectRatio
            
            //lineup centers
            tempImageView.center = photoViewController.imageView.center
            
        }) { (finished: Bool) -> Void in
            
            feedViewController.selectedImageView.hidden = false
            photoViewController.imageView.hidden = false
            tempImageView.removeFromSuperview()
            
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let photoViewController = fromViewController as! PhotoViewController
        let tabViewController = toViewController as! UITabBarController
        let feedViewController = tabViewController.selectedViewController as! FeedViewController
        
        let tempImageView = UIImageView()
        tempImageView.image = photoViewController.imageView.image
        tempImageView.contentMode = feedViewController.selectedImageView.contentMode
        
        // aspect ratio
        let aspectRatio = tempImageView.image!.size.width / tempImageView.image!.size.height
        
        // respect frame
        tempImageView.frame.size.width = photoViewController.imageView.frame.size.width
        tempImageView.frame.size.height = tempImageView.frame.size.width / aspectRatio

        // centers
        tempImageView.center = photoViewController.imageView.center
        
        photoViewController.imageView.hidden = true
        feedViewController.selectedImageView.hidden = true
        containerView.addSubview(tempImageView)

        feedViewController.view.alpha = 1
        
        /*
        
         some older stuff i was trying before I saw Tim's post
         
        // feed frame
        // get the tempImage frame x, y and scrollview Y frame
        let feedImageFrameX = feedViewController.selectedImageView.frame.minX
        let feedImageFrameY = feedViewController.selectedImageView.frame.minY
        let feedScrollViewFrameY = feedViewController.scrollView.frame.minY
        
        // doesn't account for when the scrollview has scrolled, would subtract that in the Y here
        let feedImagePoint = CGPoint(x: feedImageFrameX, y: feedImageFrameY + feedScrollViewFrameY)
        let feedImageFrame = CGRect(origin: feedImagePoint, size: feedViewController.selectedImageView.frame.size)
 
         */
        
        UIView.animateWithDuration(duration, animations: {
            
            photoViewController.view.alpha = 0
            
            tempImageView.frame = containerView.convertRect(feedViewController.selectedImageView.frame, fromView: feedViewController.selectedImageView.superview)
            
            //tempImageView.center = feedViewController.selectedImageView.center
            
            
        }) { (finished: Bool) -> Void in
            
            feedViewController.selectedImageView.hidden = false
            photoViewController.imageView.hidden = false
            tempImageView.removeFromSuperview()
            
            self.finish()
        }
    }
}
