//
//  ViewSightViewController.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 20/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ViewSightViewController: UIViewController {

    let allSightInfo = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var sightTitle: UILabel!
    @IBOutlet weak var sightInfo: UITextView!
    @IBOutlet weak var sightPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentSightTitle = String(allSightInfo.objectForKey("sightTitle")!)
        sightTitle.text = currentSightTitle
        
        // Gets the information of the sight that the user wants to see
        let query = PFQuery(className: "AddedSight")
        query.whereKey("SightTitle", equalTo: currentSightTitle)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                self.sightInfo.text = String(objects![0]["SightInfo"])
                let currentSightPhoto = objects![0]["imageFile"] as! PFFile
                currentSightPhoto.getDataInBackgroundWithBlock {
                    (imageData: NSData?, error: NSError?) -> Void in
                    if imageData !== nil {
                        let image = UIImage(data: imageData!)
                        self.sightPhoto.image = image
                    } else {
                        print (error)
                    }
                }
            } else {
                print (error)
            }
        }
    }
    
}
