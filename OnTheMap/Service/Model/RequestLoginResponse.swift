//
//  RequestLoginResponse.swift
//  OnTheMap
//
//  Created by Wladmir Júnior on 27/01/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import Foundation

struct RequestLoginResponse: Codable {
    public var account: Account
    public var session: Session
}

struct Account: Codable {
    public var registered: Bool
    public var key: String
}

struct Session: Codable {
    public var id: String
    public var expiration: String
}
