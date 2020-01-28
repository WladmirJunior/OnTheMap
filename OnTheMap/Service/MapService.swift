//
//  MapService.swift
//  OnTheMap
//
//  Created by Wladmir Júnior on 27/01/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import Foundation

class MapService {
    
    let studentLocationUrl = "https://onthemap-api.udacity.com/v1/StudentLocation"
    let userSessionUrl = "https://onthemap-api.udacity.com/v1/session"
    
    func loadData(completion: @escaping(([Student]?, String?) -> ())) {
        if let url = URL(string: "\(studentLocationUrl)?limit=100&order=-updatedAt") {
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
        if let url = URL(string: studentLocationUrl) {
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
    
    func logout(completion: @escaping((String?) -> ())) {
        if let url = URL(string: userSessionUrl) {
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            var xsrfCookie: HTTPCookie? = nil
            let sharedCookieStorage = HTTPCookieStorage.shared
            for cookie in sharedCookieStorage.cookies! {
              if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
            }
            if let xsrfCookie = xsrfCookie {
              request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
            }
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let range = 5..<data.count
                    let newData = data.subdata(in: range)
                    print(String(data: newData, encoding: .utf8)!)
                    completion(nil)
                } else {
                    completion(error?.localizedDescription)
                }
            }.resume()
        }
    }
}
