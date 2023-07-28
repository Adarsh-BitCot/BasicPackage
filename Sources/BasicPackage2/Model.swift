//
//  Model.swift
//  Created by bitcot on 28/07/23.
//

import Foundation

struct Model <T: Codable>: Codable {
    let page : Int?
    let per_page : Int?
    let total : Int?
    let total_pages : Int?
    let data : [Data]?
}
