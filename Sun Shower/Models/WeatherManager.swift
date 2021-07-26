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
            // Completion handler takes a function as a value; Data?, URLResponse, and Error? are function parameters; function returns nothing.
            //            // Completion handler triggered by task after session completes networking and task is complete.
            //            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    // Exit function and do not continue
                    return
                }
                // Use optional binding to unwrap data
                if let safeData = data {
                    parseJSON(weatherData: safeData)
                    
                    // View data in XCode inspector
                    //                    let dataString = String(data: safeData, encoding:.utf8)
                    //                    print(dataString!)
                }
            }
            // Start task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        
        // .self turns WeatherData into a data type (instead of object)
        // throw keyword indicates that if something goes wrong, method will throw an error
        // .decode moth
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.name)
        } catch {
            print(error)
        }
    }
    
}
