//
//  RequestLogin.swift
//  OnTheMap
//
//  Created by Wladmir Júnior on 27/01/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import Foundation

struct RequestLogin: Codable {
    public var udacity: Udacity
}

struct Udacity: Codable{
    public var username: String
    public var password: String
}
