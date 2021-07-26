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
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // Create a URL with URL initializer
        if let url = URL(string: urlString) {
            
            // Create a URLSession (object that performs networking)
            let session = URLSession(configuration: .default)
            
            // Give session a task
            // .dataTask returns a URLSessionDataTask
            // Completion handler takes a function as a value; Data?, URLResponse, and Error? are function parameters
            let task = session.dataTask(with: url, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
            
            // Start task
            task.resume()
            
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
        
    }
}
