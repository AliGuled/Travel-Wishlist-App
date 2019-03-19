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
    
    let locations: Places
    var coordinate: CLLocationCoordinate2D { return locations.coordinate }
    
    init(point: Places) {
        self.locations = point
        super.init()
    }
    
    var title: String? {
        return locations.name
    }
    
    var subtitle: String? {
        return "(\(locations.coordinate.latitude), \(locations.coordinate.longitude))"
    }

}
    

