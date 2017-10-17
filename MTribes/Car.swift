//
//  Car.swift
//  MTribes
//
//  Created by Deepesh Gairola on 16/10/17.
//  Copyright © 2017 Deepesh Gairola. All rights reserved.
//

import Foundation
import ObjectMapper

class Car: Mappable {
    
    var address: String?
    var name: String?
    var coordinates: [Any]?
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {

        address <- map["address"]
        name <- map["name"]
        coordinates <- map["coordinates"]
        
    }
}
