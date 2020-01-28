//
//  UserDataResponse.swift
//  OnTheMap
//
//  Created by Wladmir Júnior on 28/01/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import Foundation

struct UserDataResponse: Codable {
    let lastName: String
    let firstName: String
    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case firstName = "first_name"
    }
}
