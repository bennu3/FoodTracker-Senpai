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
    private let regionMeters: Double = 5000
    private var restaurantAddress: Address?
    private let locationManager = LocationManager.shared
    private var placesList: [MKMapItem] = []
    var categoryFavoriteRestaurant: [String] = []
    private var placeListRestaurant: [Restaurant] = [] {
        didSet {
            for restaurant in placeListRestaurant {
                let annotation = RestaurantsAnnotations(restaurant: restaurant)
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        NotificationCenter.default.addObserver(forName: .saveSelectedCategory, object: nil, queue: OperationQueue.main) { (notification) in
            let categorySelectedVC = notification.object as! CategoryPopUpViewController
            for item in categorySelectedVC.categorySelectedData {
                self.categoryFavoriteRestaurant.append(item)
                
            }
        }
        
        if locationManager.locationServicesEnabled() {
            locationManager.startUpdatingAlwaysLocation()
        } else {
            showLocationServicesAlert()
        }

        favoriteRestaurants()
    }
    
    private func centerMapOnUserLocation() {
        guard let lastLocation = locationManager.location else { return }
        
        mapView.center(on: lastLocation,
                       latitudinalMeters: regionMeters,
                       longitudinalMeters: regionMeters)
        
    }
    
    
    func favoriteRestaurants() {
        
        let request = MKLocalSearch.Request()
//        for favorite in categoryFavoriteRestaurant {
            request.naturalLanguageQuery = "pizza"
//        }
                request.region = mapView.region
                let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard error == nil else {
                print("Error occurred in search: \(error!.localizedDescription)")
                return
            }
            
            guard (response != nil) else { return }
            
            
            for item in response!.mapItems {
                self.placesList.append(item)
            }
            
            for places in self.placesList {
                
                self.restaurantNameLabel.text = places.placemark.title
                let location = (places.placemark.coordinate.latitude, places.placemark.coordinate.longitude)
                let address = Address(location: location)
                guard let name = places.placemark.name else {return}
                guard let description = places.placemark.title else {return}
                let restaurant = Restaurant(name: name, description: description, address: address)
                self.placeListRestaurant.append(restaurant)
                let annotation = RestaurantsAnnotations(restaurant: restaurant)
                self.mapView.addAnnotation(annotation)
                
                self.mapView.center(on: restaurant.address.location,
                                    latitudinalMeters: self.regionMeters,
                                    longitudinalMeters: self.regionMeters)
                }
            }
        }
    
    func selectRestaurant() {

//        let profileController = storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileViewController
//        profileController.foodName = "el nombre de comida que retorno CoreML"
//        profileController.foodImage = nil //aca va la imagen que me da CoreML
//        //paso todos los datos de comida que sean necesarios
//
//        present(profileController, animated: true)
    }
    
    
    private func update(selectedRestaurant: Restaurant) {
        
        restaurantNameLabel.text = selectedRestaurant.name
        typeFoodLabel.text = selectedRestaurant.description
        restaurantImageView.image = UIImage(named: selectedRestaurant.imageURL)
        infoRestaurantView.isHidden = false
        infoRestaurantView.layer.cornerRadius = 180
        infoRestaurantView.layer.cornerRadius = 20
        infoRestaurantView.layer.shadowColor = UIColor.gray.cgColor
        infoRestaurantView.layer.shadowOpacity = 0.8
        infoRestaurantView.layer.shadowOffset = CGSize.zero
        infoRestaurantView.layer.shadowRadius = 5
    }
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
        case .notDetermined:
            break
        }
    }
    
}

extension MapController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if annotation is MKPointAnnotation {
            let annotationView = RestaurantAnnotationView(annotation: annotation, reuseIdentifier: "RestaurantsAnnotations")
            return annotationView
        }

        return nil
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let view = view as? RestaurantAnnotationView else {
            return
        }

        guard let annotation = view.annotation as? RestaurantsAnnotations else {
            return
        }
        
            for item in placeListRestaurant {
                annotation.restaurant.name = item.name
                annotation.restaurant.address = item.address
        }

        update(selectedRestaurant: annotation.restaurant)
        view.select()

        inforRestaurantViewHeightConstraint.constant = 200
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 6, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard let view = view as? RestaurantAnnotationView else {
            return
        }

        view.deselect()

        inforRestaurantViewHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 6, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 2
        return renderer
    }
    
}


