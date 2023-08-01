//
//  BaseModel.swift
//  PackageExample
//
//  Created by bitcot on 29/07/23.
//

import Foundation

struct BaseModel <T: Codable>: Codable {
    let responseData : ResponseData?
    let support : Support?
    
    enum CodingKeys: String, CodingKey {
        case responseData = "data"
        case support
    }
}

struct ResponseData : Codable {
    let id : Int?
    let email : String?
    let first_name : String?
    let last_name : String?
    let avatar : String?
}

struct Support : Codable {
    let url : String?
    let text : String?
}
