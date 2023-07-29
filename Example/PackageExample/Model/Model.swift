//
//  BaseModel.swift
//  PackageExample
//
//  Created by bitcot on 29/07/23.
//

import Foundation

struct BaseModel : Codable {
    let data : Data?
    let support : Support?
}

struct Data : Codable {
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
