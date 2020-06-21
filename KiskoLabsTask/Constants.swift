//
//  Constants.swift
//  KiskoLabsTask
//
//  Created by Hassan Shahid on 11/06/2020.
//  Copyright © 2020 Hassan Shahid. All rights reserved.
//

import Foundation

struct Constants{

    static let BaseURL = "https://api.unsplash.com/"
    
    static let sceretKey = "Authorization: Client-ID JnEtmbse1hj4koLtPkyktG_ryqT-dJgXxLKN7cqaThg"
}

struct CacheValue {
    static let foodData = "foodData"
}

class DataCache: NSObject {
    static let sharedInstance = DataCache()
    var cache = [String.self, AnyObject.self] as [Any]
}
