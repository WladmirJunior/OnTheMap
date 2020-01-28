//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Wladmir Júnior on 28/01/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController {

    @IBOutlet weak var viewLabelTop: UIView!
    @IBOutlet weak var viewFieldMid: UIView!
    @IBOutlet weak var textFieldMid: UITextField!
    @IBOutlet weak var viewFieldTop: UIView!
    @IBOutlet weak var textFieldTop: UITextField!
    
    @IBOutlet weak var buttonFind: UIButton!
    @IBOutlet weak var buttonSubmit: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel: MapViewModel?
    var user: RequestLoginResponse?
    var userData: UserDataResponse?
    
    var longitude: CLLocationDegrees = 0.0
    var latitude: CLLocationDegrees = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        mapView.delegate = self
        
        textFieldMid.attributedPlaceholder = NSAttributedString(string: "Enter Your Location Here",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

        textFieldTop.attributedPlaceholder = NSAttributedString(string: "Enter a Link to Share Here",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    
    @IBAction func clickFind(_ sender: Any) {
        buttonFind.isHidden = true
        buttonSubmit.isHidden = false
        viewLabelTop.isHidden = true
        viewFieldMid.isHidden = true
        viewFieldTop.isHidden = false
        mapView.isHidden = false
        
        findLocation(address: textFieldMid.text!)
    }
    
    @IBAction func submit(_ sender: Any) {
        let locationRequest = SendUserLocationRequest(firstName: userData?.firstName ?? "",
                                                      lastName: userData?.lastName ?? "",
                                                      longitude: self.longitude,
                                                      latitude: self.latitude,
                                                      mapString: textFieldMid.text!,
                                                      mediaURL: textFieldTop.text!,
                                                      uniqueKey: user?.account.key ?? "")
        
        
        viewModel?.sendUserLocation(with: locationRequest, completion: { [weak self] error in
            if let error = error {
                print(error)
            } else {
                
                DispatchQueue.main.async {
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func findLocation(address: String) {
        let locationManager = CLGeocoder()
        locationManager.geocodeAddressString(address) { [weak self] placemarks, error in
            if let placemark = placemarks?[0] {
                self?.latitude = placemark.location!.coordinate.latitude
                self?.longitude = placemark.location!.coordinate.longitude
                
                self?.setLocation()
            } else {
                self?.showAlert(AndMessage: "Error on find address")
            }
        }
    }
    
    private func setLocation() {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
               
        self.mapView.setRegion(region, animated: true)
        
        var annotations = [MKPointAnnotation]()
        let coordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        
        
        let annotation = MKPointAnnotation()
        let mapString = textFieldMid.text ?? "-"
        annotation.coordinate = coordinate
        annotation.title = "\(mapString)"
        annotation.subtitle = ""
        
        annotations.append(annotation)
        self.mapView.addAnnotations(annotations)
        self.mapView.reloadInputViews()
    }
}

extension AddLocationViewController: MKMapViewDelegate {
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(withTitle title: String? = "", AndMessage message: String) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle:.alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertViewController, animated: true, completion: nil)
    }
}
