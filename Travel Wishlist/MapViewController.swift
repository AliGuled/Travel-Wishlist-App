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
    var allLocations = [Places]()
    var locations: Places!
    //Creating mapview object
    var mapView: MKMapView!
    var geoCoder =  CLGeocoder()
    
    var latitudeDelta = 0.3
    var longitudeDelta = 0.3
    
    var visition: VisitationTableViewController!

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
        
        performSegue(withIdentifier: "place", sender: leftButton)
        
        
        
    }
    
  
  
    @objc func rightbarButton() {
       
        print("Right barButton")
    }
    
    var coori : CLLocationCoordinate2D  {
        let recongnizer = UITapGestureRecognizer()
        let locationPoint = recongnizer.location(in: mapView)
        let cooridinate = mapView.convert(locationPoint, toCoordinateFrom: mapView)

        return cooridinate
        
    }
    
    //Create add butoon
    @objc  func createTabReconizer(recongnizer: UITapGestureRecognizer) {
    
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coori
        
        mapView.addAnnotation(annotation)
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coori.latitude, longitude: coori.longitude), span: span)
        mapView.setRegion(region, animated: true)
        
        
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: coori.latitude, longitude: coori.longitude)) {(placeMarks : [CLPlacemark]?, error: Error?) in
            if let placeLocation = placeMarks?[0] {
                
                if error == nil && (placeMarks?.count)! > 0 {
                    
                    let locationString = "Want to go here? \(placeLocation.name!)"
                    annotation.coordinate = self.coori
                    annotation.title = locationString
                    let newPlace = Places(name: locationString, place: CLLocationCoordinate2D(latitude: self.coori.latitude, longitude: self.coori.longitude), isVisited: true)
                        
                        self.allLocations.append(newPlace)
                        print(newPlace.name)
                        print(newPlace.cooridinate)
                        print(newPlace.isVisited)
                        
                        
                        
                        
                    }
                    
                }
            
            }
        
        }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Annation view tapped")
        view.backgroundColor = .purple
        view.tintColor = .white
       
        view.transform = CGAffineTransform.identity
        view.canShowCallout = true
        view.isDraggable = true
        view.dragState = .dragging
        view.displayPriority = .defaultHigh
        view.setNeedsDisplay()
    }
    
 
}





    

