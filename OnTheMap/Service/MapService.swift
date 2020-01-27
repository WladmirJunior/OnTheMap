//
//  MapService.swift
//  OnTheMap
//
//  Created by Wladmir Júnior on 27/01/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import Foundation

class MapService {
    
    init() {
        
    }
    
    func loadData(completion: @escaping(([Student]?, String?) -> ())) {
        if let url = URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation?limit=2") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(Results.self, from: data)
                        completion(res.results, nil)
                        print(res)
                    } catch let error {
                        print(error)
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    completion(nil, error?.localizedDescription)
                }
            }.resume()
        }
    }
    
    func sendUserLocation(with requestLocation: SendUserLocationRequest, completion: @escaping((String?) -> ())) {
        if let url = URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation") {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONEncoder().encode(requestLocation)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(SendUserLocationResponse.self, from: data)
                        completion(nil)
                        print(res)
                    } catch let error {
                        print(error)
                        completion(error.localizedDescription)
                    }
                } else {
                    completion(error?.localizedDescription)
                }
            }.resume()
        }
    }
}
