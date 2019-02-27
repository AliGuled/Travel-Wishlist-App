//
//  ViewController.swift
//  Travel Wishlist
//
//  Created by Guled Ali on 2/26/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {
    
    var placeList: PlaceList!
    var places: Places!
    //Creating mapview object
    var mapView: MKMapView!
    var geoCoder =  CLGeocoder()
    
    //the object that determines the location
    let placeManger = CLLocationManager()
    
    //loading the map on the scene
    override func loadView() {
        super.loadView()
        mapView = MKMapView()
        view = mapView
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       navigationItem.title = "Travel Wishlist"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        placeManger.delegate = self
        placeManger.requestWhenInUseAuthorization()
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(createTabReconizer(recongnizer:)))
        mapView.addGestureRecognizer(tabGesture)
    }
    
    //Create add butoon
  @objc  func createTabReconizer(recongnizer: UITapGestureRecognizer) {
    if let location = placeManger.location {
    let locationPoint = recongnizer.location(in: mapView)
    let cooridinate = mapView.convert(locationPoint, toCoordinateFrom: mapView)
    
    let annotation = MKPointAnnotation()
    annotation.coordinate = cooridinate
    mapView.addAnnotation(annotation)
    
    geoCoder.reverseGeocodeLocation(location) { (placeMarks: [CLPlacemark]?, error: Error?) in
        
        
        if error == nil {
            
            
            
            print("Error free")
            
            
            }
        }
    }
}
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKPointAnnotation {
            let pinAnnoation = MKPinAnnotationView()
            pinAnnoation.tintColor = UIColor.purple
            pinAnnoation.annotation = annotation
            pinAnnoation.canShowCallout = true
            return pinAnnoation
        }
        return nil

    }




}

