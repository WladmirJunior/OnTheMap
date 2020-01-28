//
//  TabBarViewController.swift
//  OnTheMap
//
//  Created by Wladmir Júnior on 27/01/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var user: RequestLoginResponse?
    var userData: UserDataResponse?
    var viewModel: MapViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MapViewModel()
        
        let viewController1 = viewControllers?[0] as! MapViewController
        viewController1.viewModel = viewModel
        
        let viewController2 = viewControllers?[1] as! ListTableViewController
        viewController2.viewModel = viewModel
    }
    
    @IBAction func reload(_ sender: Any) {
        for viewController in viewControllers! {
            guard let controller = viewController as? MainScreenTab else {
                fatalError("\(viewController) need implement MainScreenDelegate")
            }
            controller.loadData()
        }
    }
    
    @IBAction func addLocation(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "addLocationViewController") as! AddLocationViewController
        controller.viewModel = self.viewModel
        controller.user = self.user
        controller.userData = self.userData
        
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        viewModel?.logout(completion: { [weak self] error in
            if let error = error {
                self?.showAlert(withTitle: "Error", AndMessage: error)
            } else {
                DispatchQueue.main.async {
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
}

public protocol MainScreenTab {
    
    func loadData()
}
