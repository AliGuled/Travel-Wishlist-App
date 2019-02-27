//
//  PlaceList.swift
//  Travel Wishlist
//
//  Created by Guled Ali on 2/26/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import UIKit

class PlaceList{
    var allPlaces = [Places]()
    
    func createPlace() -> Places {
        
        let newPlace = Places(name: "New York???", isVisited: true, info: "Beautiful ??")
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
