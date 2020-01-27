//
//  TabBarViewController.swift
//  OnTheMap
//
//  Created by Wladmir Júnior on 27/01/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = MapViewModel()
        
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
        
    }
}

public protocol MainScreenTab {
    
    func loadData()
    
    func sendUserLocation()
}
