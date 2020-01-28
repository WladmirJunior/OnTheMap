//
//  LoginService.swift
//  OnTheMap
//
//  Created by Wladmir Edmar Silva Junior on 27/01/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import Foundation

class LoginService {
    
    init() {
        
    }
    
    func authenticate(with requestLogin: RequestLogin, completion: @escaping((RequestLoginResponse?, String?) -> ())) {
        if let url = URL(string: "https://onthemap-api.udacity.com/v1/session") {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONEncoder().encode(requestLogin)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let range = 5..<data.count
                        let newData = data.subdata(in: range)
                        let res = try JSONDecoder().decode(RequestLoginResponse.self, from: newData)
                        completion(res, nil)
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
    
    func getUserData(with id: String, completion: @escaping((UserDataResponse?, String?) -> ())) {
        if let url = URL(string: "https://onthemap-api.udacity.com/v1/users/\(id)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let range = 5..<data.count
                        let newData = data.subdata(in: range)
                        let res = try JSONDecoder().decode(UserDataResponse.self, from: newData)
                        completion(res, nil)
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
}
