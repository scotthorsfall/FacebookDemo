//
//  FeedViewController.swift
//  FacebookDemo
//
//  Created by Scott Horsfall on 6/18/16.
//  Copyright © 2016 Scott Horsfall. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImage: UIImageView!
    
    var selectedImageView: UIImageView!
    
    var pictureTransition: PictureTransition!
    
    var fadeTransition: FadeTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = feedImage.frame.size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        
        let destinationViewController = segue.destinationViewController as! PhotoViewController
        
        destinationViewController.image = selectedImageView.image
        
        // Set the modal presentation style of your destinationViewController to be custom.
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        // Create a new instance of your fadeTransition.
        pictureTransition = PictureTransition()
        
        // Tell the destinationViewController's  transitioning delegate to look in fadeTransition for transition instructions.
        destinationViewController.transitioningDelegate = pictureTransition
        
        // Adjust the transition duration. (seconds)
        pictureTransition.duration = 1.0
        
    }
    
    @IBAction func onWeddingPhotoTap(sender: UITapGestureRecognizer) {
                
        selectedImageView = sender.view as! UIImageView
        
        performSegueWithIdentifier("photoSegue", sender: self)
    }
    

}
