//
//  MapViewModel.swift
//  OnTheMap
//
//  Created by Wladmir Júnior on 26/01/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import Foundation

class MapViewModel {
    
    var service: MapService
    var students: [Student]
    
    init() {
        service = MapService()
        students = [Student]()
    }
    
    func loadData(completion: @escaping(String?) -> ()) {
        service.loadData { students, error in
            if let students = students {
                self.students = students
                completion(nil)
            } else {
                if let error = error {
                    completion(error)
                } else {
                    completion("Error on get data.")
                }
            }
        }
    }
    
    func sendUserLocation(with request: SendUserLocationRequest, completion: @escaping(String?) -> ()) {
        service.sendUserLocation(with: request) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func logout(completion: @escaping(String?) -> ()) {
        service.logout { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}
