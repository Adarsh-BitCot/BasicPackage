//
//  BaseModel.swift
//  PackageExample
//
//  Created by Adarsh Sharma on 29/07/23.
//

import Foundation

struct BaseModel <T: Codable>: Codable {
    let support : Support?
    let job : String?
    let name : String?
    let id : String?
    let createdAt : String?
    let page : Int?
    let per_page : Int?
    let total : Int?
    let total_pages : Int?
    let responseData : [ResponseData]?
    let error: String?
    let token: String?
    
    enum CodingKeys: String, CodingKey {
        case support
        case job
        case name
        case id
        case createdAt
        case page
        case per_page
        case total
        case total_pages
        case responseData = "data"
        case error
        case token
    }
}

struct ResponseData : Codable {
    let id : Int?
    let email : String?
    let first_name : String?
    let last_name : String?
    let avatar : String?
    let name : String?
    let year : Int?
    let color : String?
    let pantone_value : String?
}

struct Support : Codable {
    let url : String?
    let text : String?
}
