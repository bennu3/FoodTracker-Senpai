//
//  Searching.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/19/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import UIKit
import MapKit

struct Search {

    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearch.Request!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearch.Response!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
}

