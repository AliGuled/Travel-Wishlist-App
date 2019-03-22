//
//  Places.swift
//  Travel Wishlist
//
//  Created by Guled Ali on 2/26/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import  CoreLocation
import Foundation

class Places: NSObject {
    
    
    //location name
    var name: String
    var coordinate: CLLocationCoordinate2D //coordinate string
    
    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.coordinate = coordinate
    }

}
