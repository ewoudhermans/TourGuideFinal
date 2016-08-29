//
//  AddSightByTabViewController.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 26/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Parse
import Bolts

class AddSightByTabViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var sightTitle: UITextField!
    @IBOutlet weak var sightInfo: UITextField!
    @IBOutlet weak var previewImage: UIImageView!
    
    let tabLocation = NSUserDefaults.standardUserDefaults()
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    var sightCity = ""
    var locationArray: [CLLocationDegrees] = [CLLocationDegrees]()

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [NSObject : AnyObject]?) {
        previewImage.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func selectImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func submitSight(sender: AnyObject) {
        let testArray: AnyObject? = tabLocation.objectForKey("myTabLocation")
        let readArray: [CLLocationDegrees] = testArray! as! [CLLocationDegrees]
        
        latitude = readArray.last!
        longitude = readArray.first!
        
        let sightGeopoint = PFGeoPoint(latitude: longitude, longitude: latitude)
        
        let addsight = AddSight(sInfo: sightInfo.text!, sTitle: sightTitle.text!, sPhoto: previewImage, sLatitude: latitude , sLongitude: longitude, sGeopoint: sightGeopoint)
        addsight.addSight({ (succes) -> Void in
            if succes {
                let alert = self.succesAddedSight()
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
        for key in tabLocation.dictionaryRepresentation().keys {
            tabLocation.removeObjectForKey(key)
        }
    }
    
    func succesAddedSight() -> UIAlertController {
        let alertView = UIAlertController(title: "Data added", message: "Your sight was successfully added", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Main", style: .Default, handler: { (alertAction) -> Void in self.dismissViewControllerAnimated(true, completion: nil)
        }))
        alertView.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        return alertView
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}

