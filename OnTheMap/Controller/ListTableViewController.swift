//
//  ListTableViewController.swift
//  OnTheMap
//
//  Created by Wladmir Júnior on 26/01/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, MainScreenTab {

    var viewModel: MapViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadData()
    }
    
    func loadData() {
        viewModel.loadData { [weak self] error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.showAlert(AndMessage: error)
                }
            } else {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func showAlert(withTitle title: String? = "", AndMessage message: String) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle:.alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertViewController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.students.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let location = viewModel.students[indexPath.row]
        
        cell.textLabel?.text = location.firstName
        cell.imageView?.image = UIImage(named: "icon_pin")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = viewModel.students[indexPath.row]
        
        let app = UIApplication.shared
        if let toOpen = URL(string: location.mediaURL) {
            app.openURL(toOpen)
        }
    }
}
