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
    
    func sendUserLocation(completion: @escaping(String?) -> ()) {
        let locationRequest = SendUserLocationRequest(firstName: "Teste 007",
                                                      lastName: "Last 007",
                                                      longitude: 0,
                                                      latitude: 0,
                                                      mapString: "Tarpon Springs, FL",
                                                      mediaURL: "www.google.com",
                                                      uniqueKey: "987236496")
        service.sendUserLocation(with: locationRequest) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func hardCodedLocationData() -> [[String : Any]] {
        return  [
            [
                "createdAt" : "2015-02-24T22:27:14.456Z",
                "firstName" : "Jessica",
                "lastName" : "Uelmen",
                "latitude" : 28.1461248,
                "longitude" : -82.75676799999999,
                "mapString" : "Tarpon Springs, FL",
                "mediaURL" : "www.linkedin.com/in/jessicauelmen/en",
                "objectId" : "kj18GEaWD8",
                "uniqueKey" : 872458750,
                "updatedAt" : "2015-03-09T22:07:09.593Z"
            ], [
                "createdAt" : "2015-02-24T22:35:30.639Z",
                "firstName" : "Gabrielle",
                "lastName" : "Miller-Messner",
                "latitude" : 35.1740471,
                "longitude" : -79.3922539,
                "mapString" : "Southern Pines, NC",
                "mediaURL" : "http://www.linkedin.com/pub/gabrielle-miller-messner/11/557/60/en",
                "objectId" : "8ZEuHF5uX8",
                "uniqueKey" : 2256298598,
                "updatedAt" : "2015-03-11T03:23:49.582Z"
            ], [
                "createdAt" : "2015-02-24T22:30:54.442Z",
                "firstName" : "Jason",
                "lastName" : "Schatz",
                "latitude" : 37.7617,
                "longitude" : -122.4216,
                "mapString" : "18th and Valencia, San Francisco, CA",
                "mediaURL" : "http://en.wikipedia.org/wiki/Swift_%28programming_language%29",
                "objectId" : "hiz0vOTmrL",
                "uniqueKey" : 2362758535,
                "updatedAt" : "2015-03-10T17:20:31.828Z"
            ], [
                "createdAt" : "2015-03-11T02:48:18.321Z",
                "firstName" : "Jarrod",
                "lastName" : "Parkes",
                "latitude" : 34.73037,
                "longitude" : -86.58611000000001,
                "mapString" : "Huntsville, Alabama",
                "mediaURL" : "https://linkedin.com/in/jarrodparkes",
                "objectId" : "CDHfAy8sdp",
                "uniqueKey" : 996618664,
                "updatedAt" : "2015-03-13T03:37:58.389Z"
            ]
        ]
    }
}
