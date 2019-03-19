//
//  VisitationTableViewController.swift
//  Travel Wishlist
//
//  Created by Guled Ali on 3/4/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import Foundation
import UIKit

class VisitationTableViewController: UITableViewController {
    
   var poi: [Places] = []
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
         super.viewWillAppear(true)
        
        let dissButton = UIBarButtonItem(title: "Done", style: .done
            , target: self, action: #selector(dismisController))
        self.navigationItem.rightBarButtonItem = dissButton
        dissButton.tintColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Visited"
        navigationController?.navigationBar.barTintColor = .blue
        print("view didload")
        print(poi)
       
    }
    
    @objc func dismisController() {
        
        presentingViewController?.dismiss(animated: true, completion: nil)

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return poi.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        
        let point = poi[indexPath.row]
        cell.textLabel?.text = point.name
        cell.detailTextLabel?.text = "(\(point.coordinate.latitude), \(point.coordinate.longitude))"
        
        return cell
    }
    
   
    
}
