//
//  Student.swift
//  OnTheMap
//
//  Created by Wladmir Júnior on 27/01/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import Foundation

struct Results: Codable {
    let results: [Student]
}

struct Student: Codable {
    let firstName: String
    let lastName: String
    let longitude: Double
    let latitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
    let objectId: String
    let createdAt: String
    let updatedAt: String
}
