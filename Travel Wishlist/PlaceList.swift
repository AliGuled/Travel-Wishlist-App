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
    
    func createPlace() -> Places {
        let newPlace = Places(name: "place of the name", place: [CLLocation(latitude: -45, longitude: 98)], isVisited: true)
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
    

