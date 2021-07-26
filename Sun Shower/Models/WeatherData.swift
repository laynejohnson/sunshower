//
//  WeatherData.swift
//  Sun Shower
//
//  Created by Layne Johnson on 7/26/21.
//

import Foundation

// A struct that conforms to the Decodable protocol is a type that can decode itslef from an external representation (JSON representation).

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

// Property names must match property names in JSON
struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
    
}
