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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
        
        if userField.text == "user" && passField.text == "123" {
            
        } else {
            // User invalid
            let storyboard = self.storyboard
            let navigation = storyboard?.instantiateViewController(identifier: "navigation") as! UINavigationController
            navigation.modalPresentationStyle = .fullScreen
            self.present(navigation, animated: true, completion: nil)
        }
    }
    

}

