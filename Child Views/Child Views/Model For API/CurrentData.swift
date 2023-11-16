//
//  CurrentData.swift
//  Child Views
//
//  Created by Tejas Kashid on 05/11/23.
//

import Foundation
struct CurrentData: Codable {
    let last_updated: String
    let temp_c: Float
    let wind_kph: Float
    let humidity: Int
}
