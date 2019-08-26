//
//  ContainerViewController.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/16/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapController()
    }
    // MARK: - Handlers
    
    func configureMapController() {
        let mapController = MapController()
        let controller = UINavigationController(rootViewController: mapController)
        
        view.addSubview(controller.view)
        addChild(controller)
        controller.didMove(toParent: self)
    }
    
    func configureMenuController() {
    }
}
