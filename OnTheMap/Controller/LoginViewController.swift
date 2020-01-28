//
//  ViewController.swift
//  OnTheMap
//
//  Created by Wladmir  on 26/01/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: LoginViewModel?
    let signUpUdacity = "https://www.udacity.com/account/auth#!/signup"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel()
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func login(_ sender: Any) {
        guard let user = userField.text, !user.isEmpty, let pass = passField.text, !pass.isEmpty else {
            self.showAlert(AndMessage: "Type your account and password!")
            return
        }
        activityIndicator.startAnimating()
        viewModel?.login(with: user, andPassword: pass, completion: { [weak self] user, error in
            if let user = user {
                DispatchQueue.main.async {
                    self?.userField.text = ""
                    self?.passField.text = ""
                }
                self?.getUserData(with: user)
            } else {
                DispatchQueue.main.async {
                    self?.showAlert(AndMessage: error ?? "Error to enter in application. try again!")
                    self?.activityIndicator.stopAnimating()
                }
            }
        })
    }
    
    @IBAction func signUp(_ sender: Any) {
        let app = UIApplication.shared
        if let toOpen = URL(string: signUpUdacity) {
            app.openURL(toOpen)
        }
    }
    
    private func getUserData(with user: RequestLoginResponse) {
        viewModel?.getUserData(with: user.session.id, completion: { [weak self] userData, error in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                let storyboard = self?.storyboard
                let navigation = storyboard?.instantiateViewController(identifier: "navigation") as! UINavigationController
                navigation.modalPresentationStyle = .fullScreen
                
                let tabBar = navigation.viewControllers[0] as! TabBarViewController
                tabBar.user = user
                
                self?.present(navigation, animated: true, completion: nil)
            }
        })
    }
    
    func showAlert(withTitle title: String? = "", AndMessage message: String) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle:.alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertViewController, animated: true, completion: nil)
    }
}

