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

    var newPlace: Places! // Subclass of places
    
    var pointOfInterest: [Places] = [] // An array of place model
    
    //Setting the place location when is added to the list
    var poi: [Places] = [] {
        didSet {
            pointOfInterest = poi
            
        }
    }

    //Creating mapview object
    var mapView: MKMapView!
    var geoCoder =  CLGeocoder()
    
    //Initial cooridinate
    var latitude = 43.136581
    var longitude = -87.941101
    
    //Inital span
    var latitudeDelta = 0.3
    var longitudeDelta = 0.3

    //the object that determines the location
    let placeManger = CLLocationManager()
    
    //loading the map on the scene
    override func loadView() {
        super.loadView()
        mapView = MKMapView()
        view = mapView
        placeManger.startUpdatingLocation()
    }
    
    //Outlet are set when view is about to appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
       navigationItem.title = "Travel Wishlist"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .blue
        
        placeManger.delegate = self
        placeManger.requestWhenInUseAuthorization()
        mapView.delegate = self
        
        navigationItem.rightBarButtonItem = rightBar
        navigationItem.leftBarButtonItem = leftBar
        
        mapView.addGestureRecognizer(tapGestrueRecongnizer)
        centerMapInInitialCoordinates()

    }

    //Centering the initail coordinates
    func centerMapInInitialCoordinates() {
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    // When the map is tapped it calls the loadpoint of interst function
    var tapGestrueRecongnizer: UITapGestureRecognizer {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(loadPointOfInterests(recongnizer:)))
        return tapGesture

    }
    
    //Right bar button for adding place to the list
    var rightBar: UIBarButtonItem  {
       
        let rightBarButton =
            UIBarButtonItem(title: "Find a place to add",
                            style: .plain, target: self,
                            action: #selector(rightbarButton))
        rightBarButton.tintColor = .white
        
        return rightBarButton
        
    }
    
    //Left bar button for accesing the place list
    var leftBar: UIBarButtonItem  {
        
        let leftBarButton =
            UIBarButtonItem(title:
                "Places", style: .plain,
                           target: self, action: #selector(leftButton))
        leftBarButton.tintColor = .white
        
        return leftBarButton
        
    }
    //Left bar button for accesing the place list
    @objc func leftButton(leftButton: UIBarButtonItem) {
        
        print("Left BarButton")
        
        performSegue(withIdentifier: "place", sender: self)

    }
    
    //Adding locations to the place list
    @objc func rightbarButton(right: UIBarButtonItem) {
       
       self.navigationItem.rightBarButtonItem?.title = "Find a place to add"
        if newPlace != nil {
        pointOfInterest.append(newPlace)

        }
    }

    //Find a place on the map
    @objc func loadPointOfInterests(recongnizer:UITapGestureRecognizer) {
        
        let locationPoint = recongnizer.location(in: mapView)
        let cooridinate = mapView.convert(locationPoint, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = cooridinate
        mapView.addAnnotation(annotation)
         
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: cooridinate.latitude, longitude: cooridinate.longitude), span: span)
        mapView.setRegion(region, animated: true)
        
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: cooridinate.latitude, longitude: cooridinate.longitude)) {(placeMarks : [CLPlacemark]?, error: Error?) in
            if let placeLocation = placeMarks?[0] {
                
                if error == nil && (placeMarks?.count)! > 0 {
                    
                    let locationString = " \(placeLocation.name!)"
                    annotation.coordinate = cooridinate
                    annotation.title = "Want to go here?"
                    print(locationString)
                    
                    let place = Places(name: locationString, coordinate: CLLocationCoordinate2D(latitude: cooridinate.latitude, longitude: cooridinate.longitude))
                    
                    self.newPlace = place
                    
                    
                }

            }
            
        }
        
        self.navigationItem.rightBarButtonItem?.title = "Add place"
        
    }

    //Seguing waying to the visitation view Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "place" {
            let nav = segue.destination as! UINavigationController
            let detailViewControll = nav.topViewController as! VisitationTableViewController
            
            
                detailViewControll.poi = pointOfInterest

        }
        

        
    }

}





    

