//
//  Places.swift
//  Travel Wishlist
//
//  Created by Guled Ali on 2/26/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import UIKit

class Places: NSObject {
    var name: String
    var isVisited: Bool
    var info: String
    
    init(name: String, isVisited:Bool, info: String) {
        self.name = name
        self.isVisited = isVisited
        self.info = info
        
    }
}
