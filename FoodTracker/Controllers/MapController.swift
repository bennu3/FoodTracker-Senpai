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

    @IBOutlet weak var mapView: MKMapView!
    
    private let regionMeters: Double = 1000

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }


}

extension MapController: MKMapViewDelegate {
    
}
