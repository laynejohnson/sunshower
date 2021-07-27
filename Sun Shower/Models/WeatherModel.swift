//
//  WeatherModel.swift
//  Sun Shower
//
//  Created by Layne Johnson on 7/26/21.
//

import Foundation

struct WeatherModel {
    // Stored properties:
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let description: String
    
    // Change symbol day/night
//    let icon: String
    
    // Computed properties:
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321, 500:
            return "cloud.drizzle"
        case 501:
            return "cloud.rain"
        case 511:
            return "cloud.hail"
        case 502...504, 520-531:
            return "cloud.rain"
        case 600...602, 620-622:
            return "cloud.snow"
        case 611-616:
            return "cloud.sleet"
        case 701, 741:
            return "cloud.fog"
        case 711, 721:
            return "sun.haze"
        case 731, 751, 761, 762:
            return "sun.dust"
        case 771:
            return "tropicalstorm"
        case 781:
            return "tornado"
        case 800:
            return "sun.max"
        case 801:
            return "sun.min"
        case 802...803:
            return "cloud.sun"
        case 804:
            return "smoke"
        default:
            return "cloud"
        }
    }
}
