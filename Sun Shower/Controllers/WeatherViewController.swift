//
//  ViewController.swift
//  Sun Shower
//
//  Created by Layne Johnson on 7/24/21.
//  Copyright © 2021. All rights reserved.

/*
 
 // MARK: - Development List:
 
 // ---------------------------------- //
 // - - - - - - - - DEV - - - - - - -  //
 // ---------------------------------- //
 
 Features:
 // TODO: Language toggle
 // TODO: Units toggle
 // TODO: Color toggle
 // TODO: Add favorite cities
 // TODO: Add loading/fetching progress circle/animation
 
 Refactor:
 // TODO:
 
 */

import UIKit
import CoreLocation

// MARK: - View Controller

class WeatherViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    // ---------------------------------- //
    // - - - - - - -  OUTLETS - - - - - - //
    // ---------------------------------- //
    
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var colorThemeButton: UIButton!
    
    @IBOutlet weak var conditionImageView: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
   
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!

    @IBOutlet weak var textStackView: UIStackView!
    
    
    // MARK: - Variables
    
    // ---------------------------------- //
    // - - - - - - - - VARS - - - - - - - //
    // ---------------------------------- //
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Must set locationManager delegate before requesting location
        locationManager.delegate = self
        
        // Send location permission request
        locationManager.requestWhenInUseAuthorization()
        
        // Request intial location fix
        locationManager.startUpdatingLocation()
        
        weatherManager.delegate = self
        
        // Dismiss keyboard with tap gesture
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        // If gesture blocks other touches
        // tapGesture.cancelsTouchesInView = false
        
    }
    
}

// MARK: - UI Functions

//// Get country flag
//func getCountryFlag(countryCode: String) -> String {
//  return String(String.UnicodeScalarView(
//     countryCode.unicodeScalars.compactMap(
//       { UnicodeScalar(127397 + $0.value) })))
//}

// Get country name
func getCountryName(countryCode: String) -> String? {
    let current = Locale(identifier: "en_US")
    return current.localizedString(forRegionCode: countryCode)
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        
        DispatchQueue.main.async {
            
            let icon = weather.icon
            
            if icon.contains("n") {
                self.conditionImageView.image = UIImage.init(systemName: weather.nightConditionName)
            } else if icon.contains("d") {
                self.conditionImageView.image = UIImage.init(systemName: weather.dayConditionName)
            }
            
            self.cityLabel.text = weather.cityName
            let countryCode = weather.country
            let countryName = getCountryName(countryCode: countryCode)
            self.countryLabel.text = countryName
            self.descriptionLabel.text = weather.description.capitalizingFirstLetter()
            
            self.currentTemperatureLabel.text = weather.currentTemperatureString
            self.lowTemperatureLabel.text = weather.lowTemperatureString
            self.highTemperatureLabel.text = weather.highTemperatureString
          
            
            // Set country flag.
//            self.countryFlagLabel.text = getCountryFlag(countryCode: countryCode)
        }
        
    }
    
    func didFailWithError(error: Error) {
        
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        
        print("Location button pressed")
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Error: \(error)")
    }
}

// MARK: - String Extension

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}