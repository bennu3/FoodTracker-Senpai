//
//  LoginViewController.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/24/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedView))
        view.addGestureRecognizer(tapRecognizer)
        registerForNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loginIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLogin()
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func loginIfNeeded() {
        //keychain

    }
    
    private func setupLogin() {
        logoImageView.image = UIImage(named: "loginlogo")
        
        loginButton.layer.cornerRadius = 20
        loginButton.layer.shadowColor = UIColor.gray.cgColor
        loginButton.layer.shadowOpacity = 0.8
        loginButton.layer.shadowOffset = CGSize.zero
        loginButton.layer.shadowRadius = 5
        loginButton.layer.backgroundColor = UIColor.red.cgColor
    }
    
    @objc private func tappedView(_ sender: Any) {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func showErrorAlert() {
        let errorAlert = UIAlertController(title: "Atención", message: "Está seguro que desea eliminar al usuario?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Eliminar", style: .destructive, handler: { (action) in
            print("Eliminando usuario")
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
            print("Cancelando...")
        })
        
        errorAlert.addAction(deleteAction)
        errorAlert.addAction(cancelAction)
        
        present(errorAlert, animated: true)
    }
    
    private func showActionSheet() {
        let alertController = UIAlertController(title: "Compartir archivo", message: "Como desea compartir?", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
            print("Cancelando...")
        })
        
        let deleteAction = UIAlertAction(title: "Eliminar archivo", style: .destructive, handler: { (action) in
            print("Eliminando archivo")
        })
        
        let mailAction = UIAlertAction(title: "Enviar por Mail", style: .default, handler: { (action) in
            print("Enviando mail...")
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        alertController.addAction(mailAction)
        
        present(alertController, animated: true)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "popUpCategory", bundle: nil)
        guard let popup = storyboard.instantiateInitialViewController() else { return }
        self.present(popup, animated: true)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        guard let signup = storyboard.instantiateInitialViewController() else { return }
        self.present(signup, animated: true)
    }
    
    @IBAction func fbSignUpButtonPressed(_ sender: UIButton) {
    }
    @IBAction func ggButtonPressed(_ sender: UIButton) {
    }
    @IBAction func igButonPressed(_ sender: UIButton) {
    }
    
    
}
