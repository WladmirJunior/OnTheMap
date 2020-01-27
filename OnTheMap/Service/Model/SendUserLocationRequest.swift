//
//  SendUserLocationRequest.swift
//  OnTheMap
//
//  Created by Wladmir Edmar Silva Junior on 27/01/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import Foundation

struct SendUserLocationRequest: Codable {
    let firstName: String
    let lastName: String
    let longitude: Double
    let latitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
}
