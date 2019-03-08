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
    
    static var locations =  [Places]()

    
    func createPlace() -> Places {
        let newPlace = Places(name: "place of the name", place: [CLLocation(latitude: -45, longitude: 98)], isVisited: true)
        PlaceList.locations.append(newPlace)
        return newPlace
    }
    
    func removePlace(_ place: Places) {
        if let index = PlaceList.locations.index(of: place){
            PlaceList.locations.remove(at: index)
        }
    }
    
    func movePlace(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let movePlace = PlaceList.locations[fromIndex]
        
        PlaceList.locations.remove(at: fromIndex)
        PlaceList.locations.insert(movePlace, at: toIndex)
    }
 
}
    

