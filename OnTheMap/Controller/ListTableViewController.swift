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
    
    func loadData() {
        viewModel.loadData { error in
            if let error = error {
                // TODO: Add alert with this error
                print(error)
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func sendUserLocation() {
        
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
        cell.imageView?.image = UIImage(systemName: "mappin.circle")
        
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
