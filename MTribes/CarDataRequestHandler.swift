//
//  CarDataRequestHandler.swift
//  MTribes
//
//  Created by Deepesh Gairola on 17/10/17.
//  Copyright © 2017 Deepesh Gairola. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class CarDataRequestHandler: NSObject {
    
    func requestCabDataFromServer(completion:@escaping (_ result: Cars, _ error: Error?, _ statusCode: Int?) -> Void) {
        
        let url = URL(string: "http://data.m-tribes.com/locations.json")
        
        Alamofire.request(url!)
            .responseString { response in
                switch response.result {
                case .success(let value):
                        let result = Mapper<Cars>().map(JSONString: value)
                        completion(result!, nil, nil)
                    break
                case .failure(let error):
                    debugPrint("getAllAcronyms error \(error)")
                    
                }
        }
        
    }
    
}
