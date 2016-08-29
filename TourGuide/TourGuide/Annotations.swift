//
//  Annotations.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 17/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}