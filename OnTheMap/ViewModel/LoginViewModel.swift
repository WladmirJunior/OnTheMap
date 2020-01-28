//
//  LoginViewModel.swift
//  OnTheMap
//
//  Created by Wladmir Júnior on 27/01/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import Foundation

class LoginViewModel {
    
    var service: LoginService
    
    init() {
        service = LoginService()
    }
    
    func login(with user: String, andPassword pass: String, completion: @escaping(RequestLoginResponse?, String?) -> ()) {
        let request = RequestLogin(udacity: Udacity(username: user, password: pass))
    
        service.authenticate(with: request) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                if let error = error {
                    completion(nil, error)
                } else {
                    completion(nil, "Error on get data.")
                }
            }
        }
    }
    
    func getUserData(with userId: String, completion: @escaping(UserDataResponse?, String?) -> ()) {
        service.getUserData(with: userId) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                if let error = error {
                    completion(nil, error)
                } else {
                    completion(nil, "Error on get user data.")
                }
            }
        }
    }
}
