//
//  City.swift
//  WeatherApp
//
//  Created by Satya Swaroop on 08/04/23.
//

import Foundation

// MARK: - CityElement
struct CityElement: Codable {
    let name: String
    let localNames: LocalNames?
    let lat, lon: Double
    let country, state: String

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}

// MARK: - LocalNames
struct LocalNames: Codable {
    let en, ar, ja, ru: String
}

typealias City = [CityElement]
