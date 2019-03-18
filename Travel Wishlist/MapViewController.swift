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

    var placeModel: PlaceList?
    var pointOfInterest: [Places] = []

    

    //Creating mapview object
    var mapView: MKMapView!
    var geoCoder =  CLGeocoder()
    
    //Initial cooridinate
    var latitude = 43.136581
    var longitude = -87.941101
    
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
    
    func centerMapInInitialCoordinates() {
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    var tapGestrueRecongnizer: UITapGestureRecognizer {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(loadPointOfInterests(recongnizer:)))
        return tapGesture

    }
    
    var rightBar: UIBarButtonItem  {
       
        let rightBarButton =
            UIBarButtonItem(title: "Find a place to add",
                            style: .plain, target: self,
                            action: #selector(rightbarButton))
        rightBarButton.tintColor = .white
        
        return rightBarButton
        
    }
    
    var leftBar: UIBarButtonItem  {
        
        let leftBarButton =
            UIBarButtonItem(title:
                "Look up", style: .plain,
                           target: self, action: #selector(leftButton))
        leftBarButton.tintColor = .white
        
        return leftBarButton
        
    }

    @objc func leftButton(leftButton: UIBarButtonItem) {
        
        print("Left BarButton")
        
        performSegue(withIdentifier: "place", sender: leftButton)


    }
    
    @objc func rightbarButton(right: UIBarButtonItem) {
       
        addPlace()
        
     
    }
    
    func addPlace(){
       // mapView.removeAnnotations(mapView.annotations)
        
        for point in pointOfInterest {
            let pin = PlaceList(point: point)
            mapView.addAnnotation(pin as! MKAnnotation)
        }
        
        
    }
    

    @objc func loadPointOfInterests(recongnizer:UITapGestureRecognizer) {
        
        let locationPoint = recongnizer.location(in: mapView)
        let cooridinate = mapView.convert(locationPoint, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = cooridinate

        mapView.addAnnotation(annotation)
        
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: cooridinate.latitude, longitude: cooridinate.longitude)) {(placeMarks : [CLPlacemark]?, error: Error?) in
            if let placeLocation = placeMarks?[0] {
                
                if error == nil && (placeMarks?.count)! > 0 {
                    
                    let locationString = " 📌\(placeLocation.name!)"
                    annotation.coordinate = cooridinate
                    annotation.title = locationString
                    print(locationString)
        
                }
                
                
            }
            
        }
        
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
            self.navigationItem.rightBarButtonItem?.title = "Find a place to add"
    
    }
    
    private func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
      //To Do
        
       
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "place" {
            let nav = segue.destination as! UINavigationController
            let detailViewControll = nav.topViewController as! VisitationTableViewController
            
            for point in pointOfInterest {
                let pin = PlaceList(point: point)
                mapView.addAnnotation(pin as! MKAnnotation)
                detailViewControll.poi = pointOfInterest

            }
            
            
        }

        
    }

}





    

