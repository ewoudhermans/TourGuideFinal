//
//  SightTableTableViewController.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 25/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import UIKit
import Parse
import Bolts

class SightTableTableViewController: UITableViewController {

    let userLocation = NSUserDefaults.standardUserDefaults()
    var imageFiles = [PFFile]()
    var sightTitles = [String]()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "ewoudtreviaf"))

        let testArray: AnyObject? = userLocation.objectForKey("myLocation")
        let readArray: [CLLocationDegrees] = testArray! as! [CLLocationDegrees]
        
        let latitude = readArray.first!
        let longitude = readArray.last!
        let userGeoPoint: PFGeoPoint = PFGeoPoint()
        
        userGeoPoint.latitude = latitude
        userGeoPoint.longitude = longitude
        
        let query = PFQuery(className:"AddedSight")
        query.whereKey("Geopoints", nearGeoPoint: userGeoPoint)
        query.limit = 50
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                print ("ja")
                print (objects)
                for sight in objects! {
                    self.imageFiles.append(sight["imageFile"] as! PFFile)
                    self.sightTitles.append(sight["SightTitle"] as! String)
                }
            } else {
                print (error)
            }
        }
        print (sightTitles)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sightTitles.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let singleCell: SingleRowCell = tableView.dequeueReusableCellWithIdentifier("sightTableView") as! SingleRowCell
        singleCell.sightTitleLabel.text = sightTitles[indexPath.row]
        
        imageFiles[indexPath.row].getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if imageData != nil {
                let image = UIImage(data: imageData!)
                singleCell.sightImage.image = image
            }
        }
        return singleCell
    }
}
