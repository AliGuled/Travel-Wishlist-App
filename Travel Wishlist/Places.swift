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
    
    var name: String
    var isVisited: Bool
    var places = [CLLocation]()
    
    init(name: String, place: [CLLocation], isVisited:Bool) {
        self.name = name
        self.isVisited = isVisited
        self.places = place
    }
}
