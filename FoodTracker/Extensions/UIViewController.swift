//
//  UIViewController.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/14/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showLocationServicesAlert() {
        let alertController = UIAlertController(title: "Activar Location Services", message: "Debes activar los servicios de ubicación para usar esta aplicación", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Ir a Configuración", style: .default) { action in
            let url = URL(string: UIApplication.openSettingsURLString)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    
}
