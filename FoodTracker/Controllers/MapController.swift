//
//  MapController.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/14/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import UIKit
import MapKit
class MapController: UIViewController {

    //Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var infoRestaurantView: UIView!
    @IBOutlet weak var inforRestaurantViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var typeFoodLabel: UILabel!
    @IBOutlet weak var oneStartImageView: UIImageView!
    @IBOutlet weak var twoStartImageView: UIImageView!
    @IBOutlet weak var threeStartImageView: UIImageView!
    @IBOutlet weak var fourStartImageView: UIImageView!
    @IBOutlet weak var fiveStartImageView: UIImageView!
    
    
    //Variables
    private let regionMeters: Double = 1000
    private let locationManager = LocationManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.delegate = self
        if locationManager.locationServicesEnabled() {
            locationManager.startUpdatingAlwaysLocation()
        } else {
            showLocationServicesAlert()
        }
        
    }

    private func centerMapOnUserLocation() {
        guard let lastLocation = locationManager.location else {
            return
        }
        
        mapView.center(on: lastLocation,
                       latitudinalMeters: regionMeters,
                       longitudinalMeters: regionMeters)
    }
    
}
extension MapController: MKMapViewDelegate {

//func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//    if annotation is MKPointAnnotation {
//        let annotationView = RestaurantAnnotationView(annotation: annotation, reuseIdentifier: "RestaurantAnnotation")
//        return annotationView
//    }
//
//    return nil
//}
//
//func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//    guard let view = view as? RestaurantAnnotationView else {
//        return
//    }
//
//    guard let annotation = view.annotation as? RestaurantAnnotation else {
//        return
//    }
//
//    update(selectedRestaurant: annotation.restaurant)
//    view.select()
//
//    infoViewHeightConstraint.constant = 200
//    UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 6, options: .curveEaseIn, animations: {
//        self.view.layoutIfNeeded()
//    }, completion: nil)
//}
//
//func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
//    guard let view = view as? RestaurantAnnotationView else {
//        return
//    }
//
//    view.deselect()
//
//    infoViewHeightConstraint.constant = 0
//    UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 6, options: .curveEaseIn, animations: {
//        self.view.layoutIfNeeded()
//    }, completion: nil)
//}
//
//func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//    let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
//    renderer.strokeColor = UIColor.red
//    renderer.lineWidth = 2
//    return renderer
//}

}


extension MapController: LocationManagerDelegate {
    
    func locationManager(_ locataionManager: LocationManager, didUpdateLocation location: Location) {
        mapView.center(on: location, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
    }
    
    func locationManager(_ locationManager: LocationManager, didChangeAuthorizationStatus status: LocationAuthStatus) {
        switch status {
        case .authorized:
            mapView.showsUserLocation = true
            centerMapOnUserLocation()
        case .notAuthorized:
            showLocationServicesAlert()
            break
        case .notDetermined:
            break
        }
    }
    
    func locationManager(_ locationManager: LocationManager, didEnterRegionWithIdentifier id: String) {
//        let filteredRestaurants = restaurants.filter { $0.name == id }
//        guard let restaurant = filteredRestaurants.first else {
//            return
//        }
//
//        showNotification(forRestaurant: restaurant)
    }
    
    func locationManager(_ locationManager: LocationManager, didExitRegionWithIdentifier id: String) {
        print("Exit region \(id)")
    }
    
}
