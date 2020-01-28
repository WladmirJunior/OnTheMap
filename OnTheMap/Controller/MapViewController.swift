//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Wladmir  on 26/01/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MainScreenTab {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var LoadView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: MapViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadData()
    }
    
    func loadData() {
        LoadView.isHidden = false
        activityIndicator.startAnimating()
        viewModel.loadData { [weak self] error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.showAlert(AndMessage: error)
                    self?.LoadView.isHidden = true
                    self?.activityIndicator.stopAnimating()
                }
            } else {
                DispatchQueue.main.async {
                    self?.LoadView.isHidden = true
                    self?.activityIndicator.stopAnimating()
                    self?.addLocations()
                }
            }
        }
    }
    
    private func addLocations() {
        let locations = viewModel.students
        var annotations = [MKPointAnnotation]()
        
        for dictionary in locations {

            let lat = CLLocationDegrees(dictionary.latitude)
            let long = CLLocationDegrees(dictionary.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = dictionary.firstName
            let last = dictionary.lastName
            let mediaURL = dictionary.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            annotations.append(annotation)
        }
        
        DispatchQueue.main.async {
            self.mapView.addAnnotations(annotations)
        }
    }
    
    func showAlert(withTitle title: String? = "", AndMessage message: String) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle:.alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertViewController, animated: true, completion: nil)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.pinTintColor  = .red
            pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(URL(string: toOpen)!)
            }
        }
    }
}
