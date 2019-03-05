//
//  PlaceList.swift
//  Travel Wishlist
//
//  Created by Guled Ali on 2/26/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import UIKit
import CoreLocation

class PlaceList {
    
    var allPlaces = [Places]()
    var location = CLLocationCoordinate2D()
    let currentDate = Date()

    
    func createPlace() -> Places {
        let currentDate = Date()
        let newPlace = Places(location, date: currentDate, descriptionString: "??")
        allPlaces.append(newPlace)
        return newPlace
    }
    
    func removePlace(_ place: Places) {
        if let index = allPlaces.index(of: place){
            allPlaces.remove(at: index)
        }
    }
    
    func movePlace(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let movePlace = allPlaces[fromIndex]
        
        allPlaces.remove(at: fromIndex)
        allPlaces.insert(movePlace, at: toIndex)
    }
    
}
    

