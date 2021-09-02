//
//  WeatherManager.swift
//  Sun Shower
//
//  Created by Layne Johnson on 7/26/21.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    
    // Error handling
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=imperial&appid=\(openWeatherApiKey)"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        
        if cityName.contains(" ") {
            
            let cityWithSpaces = cityName.replacingOccurrences(of: " ", with: "+")
            let urlString = "\(weatherURL)&q=\(cityWithSpaces)"
            performRequest(with: urlString)
            
        } else {
            
            let urlString = "\(weatherURL)&q=\(cityName)"
            performRequest(with: urlString)
        }
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        // Create a URL with URL initializer
        if let url = URL(string: urlString) {
            
            // Create a URLSession (object that performs networking)
            let session = URLSession(configuration: .default)
            
            // Give session a task
            // .dataTask returns a URLSessionDataTask
            // Completion handler takes a function as a value; Data?, URLResponse, and Error? are function parameters; function returns nothing.
            // Completion handler triggered by task after session completes networking and task is complete.
            // let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    // Exit function and do not continue
                    return
                }
                // Use optional binding to unwrap data
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        // Send data to delegate
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    //                    // View data in console:
                    //                    let dataString = String(data: safeData, encoding:.utf8)
                    //                    print(dataString!)
                }
            }
            // Start task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        // .self turns WeatherData into a data type (instead of object)
        // throw keyword indicates that if something goes wrong, method will throw an error
        do {
            
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let conditionId = decodedData.weather[0].id
            let description = decodedData.weather[0].description
            let icon = decodedData.weather[0].icon
            let currentTemp = decodedData.main.temp
            let feelsLike = decodedData.main.feels_like
            let tempMin = decodedData.main.temp_min
            let tempMax = decodedData.main.temp_max
            let name = decodedData.name
            let message = decodedData.message
            let country = decodedData.sys.country
            
            let weather = WeatherModel(cityName: name, message: message, currentTemperature: currentTemp, feels_like: feelsLike, tempMin: tempMin, tempMax: tempMax, conditionId: conditionId, description: description, icon: icon, country: country)
            
            return weather
            
        } catch {
            
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
