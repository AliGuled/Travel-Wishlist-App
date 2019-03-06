//
//  ViewController.swift
//  Travel Wishlist
//
//  Created by Guled Ali on 2/26/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class MapViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {

    var placeList: PlaceList!
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
        placeManger.startUpdatingLocation()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       navigationItem.title = "Travel Wishlist"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        placeManger.delegate = self
        placeManger.requestWhenInUseAuthorization()
        mapView.delegate = self
       // mapView.showsUserLocation = true
        
        
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
       // print(cooridinate)
    
    let annotation = MKPointAnnotation()
    annotation.coordinate = cooridinate
    
    mapView.addAnnotation(annotation)
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: cooridinate.latitude, longitude: cooridinate.longitude), span: span)
        mapView.setRegion(region, animated: true)
   

        geoCoder.reverseGeocodeLocation(CLLocation(latitude: cooridinate.latitude, longitude: cooridinate.longitude)) {(placeMarks : [CLPlacemark]?, error: Error?) in
                if let placeLocation = placeMarks?[0] {
                    
                    if error == nil && (placeMarks?.count)! > 0 {
                    
                            let locationString = "Want to go here? \(placeLocation.name!)"
                            annotation.coordinate = cooridinate
                            annotation.title = locationString
                        
                        let newPlace = self.placeList.createPlace()
                        
                        
                        self.allPlaces.append(newPlace)
                        print(newPlace)
                        
                    }
                }
            }
        
        }
        
 
}





    

