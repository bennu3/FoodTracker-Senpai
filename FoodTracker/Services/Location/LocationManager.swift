//
//  Location.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/14/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import Foundation
import CoreLocation

typealias Location = (latidude: Double, longitude: Double)

protocol LocationManagerDelegate: AnyObject {
    func locationManager(_ locataionManager: LocationManager, didUpdateLocation location: Location)
    func locationManager(_ locationManager: LocationManager, didChangeAuthorizationStatus status: LocationAuthStatus)
    func locationManager(_ locationManager: LocationManager, didEnterRegionWithIdentifier id: String)
    func locationManager(_ locationManager: LocationManager, didExitRegionWithIdentifier id: String)
}

enum LocationAuthStatus {
    case authorized
    case notAuthorized
    case notDetermined
}

class LocationManager: NSObject {
    
    static var shared: LocationManager = LocationManager()
    weak var delegate: LocationManagerDelegate?
    
    private var locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    private func checkLocationAuthorization() {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            break
        case .denied:
            print("Usuario no dio permisos")
            break
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted:
            print("Usuario no puede dar permisos de ubicación")
            break
        @unknown default:
            fatalError("Caso no contemplado")
        }
        
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    public var location: Location? {
        guard let currentLocation = locationManager.location else {
            return nil
        }
        
        return (currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
    }
    
    public func locationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    public func startUpdatingAlwaysLocation() {
        setupLocationManager()
        checkLocationAuthorization()
    }
    
    public func distance(to location: Location) -> Double? {
        guard let userLocation = locationManager.location else {
            return nil
        }
        let clLocation = CLLocation(location: location)
        let distance = clLocation.distance(from: userLocation)
        return distance
    }
    
    public func startMonitoringRegion(withId id: String, forLocation location: Location, notifyOnEntry: Bool = true, notifyOnExit: Bool = true, radius: Double = 200) {
        let center = CLLocationCoordinate2D(location: location)
        let region = CLCircularRegion(center: center, radius: radius, identifier: id)
        
        region.notifyOnEntry = notifyOnEntry
        region.notifyOnExit = false
        locationManager.startMonitoring(for: region)
    }
    
    public func stopMonitoringRegion(withId id: String) {
        for region in locationManager.monitoredRegions {
            if region.identifier == id {
                locationManager.stopMonitoring(for: region)
                break
            }
        }
    }
    
    public func geocode(address: String, completion: @escaping ([Address]) -> ()) {
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard error == nil else {
                completion([])
                return
            }
            
            guard let placemarks = placemarks, !placemarks.isEmpty else {
                completion([])
                return
            }
            
            let addresses = placemarks.compactMap { Address(placemark: $0) }
            completion(addresses)
        }
    }
    
    public func reverseGeocode(location: Location, completion: @escaping (Address?) -> ()) {
        
        let clLocation = CLLocation(latitude: location.latidude, longitude: location.longitude)
        geocoder.reverseGeocodeLocation(clLocation) { (placemarks, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            
            guard let placemarks = placemarks, !placemarks.isEmpty else {
                completion(nil)
                return
            }
            
            let addresses = placemarks.compactMap { Address(placemark: $0) }
            
            guard let address = addresses.first else {
                completion(nil)
                return
            }
            completion(address)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let lastLocation = locations.last else {
            return
        }
        
        let location = (lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
        delegate?.locationManager(self, didUpdateLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            delegate?.locationManager(self, didChangeAuthorizationStatus: .authorized)
        case .denied:
            delegate?.locationManager(self, didChangeAuthorizationStatus: .notAuthorized)
        case .restricted:
            delegate?.locationManager(self, didChangeAuthorizationStatus: .notAuthorized)
        case .notDetermined:
            delegate?.locationManager(self, didChangeAuthorizationStatus: .notDetermined)
        @unknown default:
            fatalError("Auth status unknown")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Failed to monitor region \(region?.identifier ?? "")")
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Started monitoring region \(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Enter region: \(region.identifier)")
        delegate?.locationManager(self, didEnterRegionWithIdentifier: region.identifier)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exit region: \(region.identifier)")
        delegate?.locationManager(self, didExitRegionWithIdentifier: region.identifier)
    }
}
