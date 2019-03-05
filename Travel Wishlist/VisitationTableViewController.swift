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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dissButton = UIBarButtonItem(title: "Done", style: .done
            , target: self, action: #selector(dismisController))
        self.navigationItem.rightBarButtonItem = dissButton
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Visited"
    }
    
    
    @objc func dismisController() {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
