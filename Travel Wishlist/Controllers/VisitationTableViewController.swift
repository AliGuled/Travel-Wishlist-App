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
    
   //Sub class of the model
   var poi: [Places] = []
    
    //Shared instance of the map view controller
    var map: MapViewController!

    override func viewWillAppear(_ animated: Bool) {
        
         super.viewWillAppear(true)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Places"
        navigationController?.navigationBar.barTintColor = .blue
        print("view didload")
        print(MapViewController.self )
       
    }
    

    //Matching the number of rows to the model array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return poi.count
    }
    
    // loading the cells with model data
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        
        let point = poi[indexPath.row]
        
        cell.textLabel?.text = point.name
        cell.detailTextLabel?.text = " Cooridinate: (\(point.coordinate.latitude), \(point.coordinate.longitude))"
        
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("Button tapped")
        let point = poi[indexPath.row]
        
        //Creating alert congtroller for visiting locations
        let alerController = UIAlertController(title: "\(point.name)", message: "Have you visisted here?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let okAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
            //selectedCell.contentView.backgroundColor = UIColor.yellow
            selectedCell.textLabel?.text = "VISITED: \(point.name)"
            
            
        }
        
        alerController.addAction(cancelAction)
        alerController.addAction(okAction)
        
         present(alerController, animated: true, completion: nil)
    }
    
    
    //responding the the selected row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let point = poi[indexPath.row]

      // self.performSegue(withIdentifier: "showMap", sender: self);
        //presentingViewController?.dismiss(animated: true, completion: {
            func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
                if segue.identifier == "showMap" {
                    let nav = segue.destination as! UINavigationController
                    let detailViewControll = nav.topViewController as! MapViewController
                    
                    // let row = (sender as! NSIndexPath).row; //we know that sender is an NSIndexPath here.
                    let point = self.poi[indexPath.row]
                    
                    // let point = poi[row]
                    detailViewControll.pointOfInterest = [point]
                }
            }
            
      
        

   tableView.deselectRow(at: indexPath, animated: true)

        
    
    }
    
    
}
    

