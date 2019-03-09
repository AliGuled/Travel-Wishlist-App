//
//  Places.swift
//  Travel Wishlist
//
//  Created by Guled Ali on 2/26/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import UIKit
import  CoreLocation
class Places: NSObject {
    
    
    var latitude: Double
    var longitude: Double
    var name: String
    var isVisited: Bool
    
    var cooridinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(name: String, place: CLLocationCoordinate2D, isVisited:Bool) {
        self.name = name
        self.isVisited = isVisited
        self.latitude = place.latitude
        self.longitude = place.longitude
    }
}
