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
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    let latitude: Double
    let longitude: Double
    let date: Date
    let dateString: String
    let placeDescription: String
    
    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    
    init(_ location: CLLocationCoordinate2D, date: Date, descriptionString: String) {
        self.latitude =  location.latitude
        self.longitude =  location.longitude
        self.date = date
        self.dateString = Places.dateFormatter.string(from: date)
        self.placeDescription = descriptionString
    }
    
    convenience init(visit: CLVisit, descriptionString: String) {
        self.init(visit.coordinate, date: visit.arrivalDate, descriptionString: descriptionString)
    }
}
