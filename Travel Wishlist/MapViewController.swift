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
   

    var placeList =  [PlaceList]()
    var allPlaces = [Places]()
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
        
        
        let rightBarButton = UIBarButtonItem(title: "Add Place", style: .plain, target: self, action: #selector(rightbarButton))
        navigationItem.rightBarButtonItem = rightBarButton
        rightBarButton.tintColor = .white
        
        let leftBarButton = UIBarButtonItem(title: "Look up", style: .plain, target: self, action: #selector(leftButton))
        leftBarButton.tintColor = .white
        
        navigationItem.leftBarButtonItem = leftBarButton
        
        navigationController?.navigationBar.barTintColor = .blue
        
        
   
        
    }
    
    @objc func leftButton(leftButton: UIBarButtonItem) {
        
        print("Left BarButton")
        
        performSegue(withIdentifier: "hello", sender: leftButton)
    }
    
    
    @objc func rightbarButton() {
       
        print("Right barButton")
    }
    

    
    //Create add butoon
  @objc  func createTabReconizer(recongnizer: UITapGestureRecognizer) {
    
    let locationPoint = recongnizer.location(in: mapView)
    let cooridinate = mapView.convert(locationPoint, toCoordinateFrom: mapView)
    
    let annotation = MKPointAnnotation()
    annotation.coordinate = cooridinate
    
    mapView.addAnnotation(annotation)
   
    if let location = placeManger.location  {
    
        
       
     
            geoCoder.reverseGeocodeLocation(location) {(placeMarks : [CLPlacemark]?, error: Error?) in
                if let placeLocation = placeMarks?.first {
                    
               
                        
                        if error == nil {
                            
                            let locationString = "\(placeLocation.administrativeArea!)"
                            annotation.title = locationString
                    }
                }
            }
        }
        

        

       
    
    }
}

        
     
        
        
        
//
//        if let location = placeManger.location {
//
//            geoCoder.reverseGeocodeLocation(location) { (placeMarks : [CLPlacemark]?, error : Error?) in
//            if error == nil {
//
//                if let placeMark = placeMarks?[0] {
//                    let subthoroughfare = placeMark.subThoroughfare != nil ? placeMark.subThoroughfare : ""
//                    let thoroughfare = placeMark.thoroughfare != nil ? placeMark.thoroughfare : ""
//                    let country = placeMark.country != nil ? placeMark.locality : ""
//                    let earthRegion = placeMark.country != nil ? placeMark.country : ""
//
//                    let locationString = "\(subthoroughfare!) \(thoroughfare!) \(country!) \(earthRegion!)"
//                    print(locationString)
//
//                    let annotation = MKPointAnnotation()
//                    annotation.title = locationString
//                    self.mapView.addAnnotation(annotation)
//                    }
//                }
//            }
//
//        }
        

    
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






