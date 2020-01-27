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
    
    func sendUserLocation(with student: Student) {
        if let url = URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation") {
            
        }
    }
}
