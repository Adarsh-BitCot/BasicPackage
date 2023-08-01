//
//  BaseModel.swift
//  PackageExample
//
//  Created by bitcot on 29/07/23.
//

import Foundation

struct BaseModel <T: Codable>: Codable {
    let data : ResponseData?
    let support : Support?
    let job : String?
    let name : String?
    let id : String?
    let createdAt : String?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case support
        case job
        case name
        case id
        case createdAt
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
