//
//  PlaceList.swift
//  Travel Wishlist
//
//  Created by Guled Ali on 2/26/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import Foundation
import CoreLocation

class PlaceList : NSObject  {
    
    let locations: Places //subclass of locations
    var coordinate: CLLocationCoordinate2D { return locations.coordinate } //tapped coordinate
    
    init(point: Places) {
        self.locations = point
        super.init()
    }
    
    //Place location name
    var title: String? {
        return locations.name
    }
    //Subtitle for coordinate
    var subtitle: String? {
        return "(\(locations.coordinate.latitude), \(locations.coordinate.longitude))"
    }

}
    

