//
//  RandomPoint.swift
//  Cybe World
//
//  Created by Ihor Rudych on 3/5/18.
//  Copyright © 2018 Ihor Rudych. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation


class RandomPoint: MKPointAnnotation{
    
    var origin: CLLocation!
    //var heading:CLLocationDirection!
    
    init(origin:CLLocation) {
        self.origin = origin
        //self.heading = heading
    }
    
    func createRandomPointCoordinates(min:uint, max:uint) -> CLLocationCoordinate2D{
        let lat = self.origin.coordinate.latitude
        let long = self.origin.coordinate.longitude
        
        let meterCord = 0.00900900900901 / 1000
        
        //Generate random Meters between the maximum and minimum Meters
        let randomMeters = UInt(arc4random_uniform(max) + min)
        
        //then Generating Random numbers for different Methods
        let randomPM = arc4random_uniform(6)
        
        //Then convert the distance in meters to coordinates by Multiplying number of meters with 1 Meter Coordinate
        let metersCordN = meterCord * Double(randomMeters)
        
        //here we generate the last Coordinates
        if randomPM == 0 {
            return CLLocationCoordinate2D(latitude: lat + metersCordN, longitude: long + metersCordN)
        }else if randomPM == 1 {
            return CLLocationCoordinate2D(latitude: lat - metersCordN, longitude: long - metersCordN)
        }else if randomPM == 2 {
            return CLLocationCoordinate2D(latitude: lat + metersCordN, longitude: long - metersCordN)
        }else if randomPM == 3 {
            return CLLocationCoordinate2D(latitude: lat - metersCordN, longitude: long + metersCordN)
        }else if randomPM == 4 {
            return CLLocationCoordinate2D(latitude: lat, longitude: long - metersCordN)
        }else {
            return CLLocationCoordinate2D(latitude: lat - metersCordN, longitude:long)
        }
        
    }
}
