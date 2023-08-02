//
//  Constant.swift
//  PackageExample
//
//  Created by bitcot on 02/08/23.
//

import Foundation

var baseURL: String {
    return "https://reqres.in/api"
}

struct apiURL {
    static let login = "\(baseURL)/login"
    static let create = "\(baseURL)/users"
    
    static func listOfUser (page: Int) -> String {
        return "\(baseURL)/unknown?page=\(page)"
    }
}
