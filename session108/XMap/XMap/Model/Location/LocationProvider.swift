//
//  LocationProvider.swift
//  XMap
//
//  Created by Alex Telek on 06/03/2018.
//  Copyright © 2018 KCLTech. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationProviderDelegate: class {
    
    func didUpdateLocation(currentLocation: CLLocation)
}

class LocationProvider: NSObject, CLLocationManagerDelegate {

    private var locationManager = CLLocationManager()
    
    weak var delegate: LocationProviderDelegate?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func provideLocation() {
        
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        delegate?.didUpdateLocation(currentLocation: location)
        
        defer {
            locationManager.stopUpdatingLocation()
        }
    }
}
