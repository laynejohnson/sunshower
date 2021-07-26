//
//  WeatherManager.swift
//  Sun Shower
//
//  Created by Layne Johnson on 7/26/21.
//

import Foundation

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=imperial&appid=\(openWeatherApiKey)"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
}
