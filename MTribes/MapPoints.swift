//
//  MapPoints.swift
//  MTribes
//
//  Created by Deepesh Gairola on 17/10/17.
//  Copyright © 2017 Deepesh Gairola. All rights reserved.
//

import MapKit

class MapPoints: NSObject, MKAnnotation {
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
    
}
