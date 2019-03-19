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
        
        let dissButton = UIBarButtonItem(title: "Done", style: .done
            , target: self, action: #selector(dismisController))
        self.navigationItem.rightBarButtonItem = dissButton
        dissButton.tintColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Places"
        navigationController?.navigationBar.barTintColor = .blue
        print("view didload")
        print(poi)
       
    }
    
    //Dissmising the place table view controller
    @objc func dismisController() {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
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
    
    
    
    //responding the the selected row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let point = poi[indexPath.row]

     //Creating alert congtroller for visiting locations
    let alerController = UIAlertController(title: "Visisting?", message: "Do you want to visit here", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        let okAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
            selectedCell.contentView.backgroundColor = UIColor.red
            print("Yes pressed")

        }
        
        alerController.addAction(cancelAction)
        alerController.addAction(okAction)
        
        present(alerController, animated: true, completion: nil)
        
    
   tableView.deselectRow(at: indexPath, animated: true)
      //  dismiss(animated: true, completion: nil)

        
    
     func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Item" {
            let vc  = segue.destination as! MapViewController
        
            vc.pointOfInterest = [poi[indexPath.row]]
       

        
        
   
        
 
    }
        }
    
    }
}
    

