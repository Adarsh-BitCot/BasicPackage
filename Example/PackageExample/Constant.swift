//
//  Constant.swift
//  PackageExample
//
//  Created by bitcot on 02/08/23.
//

import Foundation

var reqresBaseURL: String {
    return "https://reqres.in/api"
}

var middlemanBaseURL: String {
    return ""
}

struct apiURL {
    static let login = "\(reqresBaseURL)/login"
    static let create = "\(reqresBaseURL)/users"
    
    static func listOfUser (page: Int) -> String {
        return "\(reqresBaseURL)/unknown?page=\(page)"
    }
}
