//
//  SignUpViewController.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/24/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var viewLabel: UIView!
    @IBOutlet weak var confirmButtonLabel: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpSetup()
    }
    
    private func signUpSetup() {
        confirmButtonLabel.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        confirmButtonLabel.layer.cornerRadius = 0.5 * confirmButtonLabel.bounds.size.width
        confirmButtonLabel.clipsToBounds = true
        confirmButtonLabel.layer.cornerRadius = 20
        confirmButtonLabel.layer.shadowColor = UIColor.gray.cgColor
        confirmButtonLabel.layer.shadowOpacity = 0.8
        confirmButtonLabel.layer.shadowOffset = CGSize.zero
        confirmButtonLabel.layer.shadowRadius = 5
        
        viewLabel.layer.cornerRadius = 20
        viewLabel.layer.shadowColor = UIColor.gray.cgColor
        viewLabel.layer.shadowOpacity = 0.8
        viewLabel.layer.shadowOffset = CGSize.zero
        viewLabel.layer.shadowRadius = 5
        
        
        
        
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    
}
