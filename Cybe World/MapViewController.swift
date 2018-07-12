//
//  MapViewController.swift
//  Cybe World
//
//  Created by Ihor Rudych on 3/5/18.
//  Copyright © 2018 Ihor Rudych. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class MapViewController:UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    var location: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.mapType = MKMapType.hybridFlyover
        self.mapView.delegate = self
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
        
        self.mapView.userTrackingMode = MKUserTrackingMode.followWithHeading
        
        let lat:CLLocationDegrees = locationManager.location!.coordinate.latitude
        let long:CLLocationDegrees = locationManager.location!.coordinate.longitude
        let latDelta:CLLocationDegrees = 0.0001
        let longDelta:CLLocationDegrees = 0.0001
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let userLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
            
        //Implementation of random point
        let orlocation = CLLocation(latitude: lat, longitude: long)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(userLocation, span)
        mapView.setRegion(region, animated: true)
        
        let randomP = RandomPoint(origin: orlocation)
        let point = randomP.createRandomPointCoordinates(min: 1, max: 10)
        let annot = MKPointAnnotation()
        annot.coordinate = point
        self.mapView.addAnnotation(annot)
        }
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        performSegue(withIdentifier: "seg1", sender: view)
    }
}
