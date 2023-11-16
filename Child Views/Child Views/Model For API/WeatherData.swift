//
//  WeatherData.swift
//  Child Views
//
//  Created by Tejas Kashid on 05/11/23.
//

import Foundation
struct WeatherData: Codable {
    let location: LocationData
    let current: CurrentData
}
