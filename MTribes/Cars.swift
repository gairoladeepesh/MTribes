//
//  Cars.swift
//  MTribes
//
//  Created by Deepesh Gairola on 16/10/17.
//  Copyright © 2017 Deepesh Gairola. All rights reserved.
//

import Foundation
import ObjectMapper

class Cars: Mappable {
    
    var car: [Car]?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {        
        car   <- map["placemarks"]
    }
}
