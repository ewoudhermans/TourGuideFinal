//
//  AddSight.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 12/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import Parse
import Bolts

class AddSight: NSObject {
    
    var sightInfo: String = ""
    var sightTitle: String = ""
    var sightPhoto: UIImageView
    var sightLatitude: CLLocationDegrees
    var sightLongitude: CLLocationDegrees
    var sightGeopoint = PFGeoPoint()
    
    init(sInfo: String, sTitle: String, sPhoto: UIImageView, sLatitude: CLLocationDegrees, sLongitude: CLLocationDegrees, sGeopoint: PFGeoPoint) {
        self.sightInfo = sInfo
        self.sightTitle = sTitle
        self.sightPhoto = sPhoto
        self.sightLatitude = sLatitude
        self.sightLongitude = sLongitude
        self.sightGeopoint = sGeopoint
    }
    
    func addSight(completion:(succes: Bool) -> Void) {
        let addedSight = PFObject(className: "AddedSight")
        
        addedSight["SightLatitude"] = sightLatitude
        addedSight["SightLongitude"] = sightLongitude
        addedSight["Geopoints"] = sightGeopoint
        addedSight["SightInfo"] = sightInfo
        addedSight["SightTitle"] = sightTitle
        
        let parseImageFile = PFFile(data: UIImageJPEGRepresentation(sightPhoto.image!, 0.1)!)
        addedSight["imageFile"] = parseImageFile
        
        addedSight.saveInBackgroundWithBlock({
            (success: Bool, error: NSError?) -> Void in
            
            if error == nil {
                print ("Data uploaded")
                completion(succes: true)
            } else {
                print (error)
                completion(succes: false)
            }
        })
    }
}


