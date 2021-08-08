//
//  WeatherData.swift
//  Sun Shower
//
//  Created by Layne Johnson on 7/26/21.
//

import Foundation

// A struct that conforms to the Decodable protocol is a type that can decode itself from an external representation (JSON representation).
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let sys: Sys
}

// Property names must match property names in JSON
struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
    let icon: String
}

struct Sys: Codable {
    let country: String
}
