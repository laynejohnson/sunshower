//
//  ViewController.swift
//  Sun Shower
//
//  Created by Layne Johnson on 7/24/21.
//

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
 // TODO: Upgrade UI
 // TODO: Update app icon
 
 Refactor:
 // TODO:
 
 */

import UIKit
import CoreLocation

// UITextFieldDelegate allow our view controller to manage the editing and validation of text field

// MARK: - View Controller

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    // ---------------------------------- //
    // - - - - - - -  OUTLETS - - - - - - //
    // ---------------------------------- //
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    
    // MARK: - Variables
    
    // ---------------------------------- //
    // - - - - - - - - VARS - - - - - - - //
    // ---------------------------------- //
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Must set locationManager delegate before requesting location.
        locationManager.delegate = self
        
        // Send location permission request.
        locationManager.requestWhenInUseAuthorization()
        
        // Request intial location fix.
        locationManager.startUpdatingLocation()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        
    }
    
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: Any) {
        // Dismiss keyboard.
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    // Function enables return key on keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss keyboard
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // Validate entry.
        if textField.text != "" {
            // Should end editing
            return true
        } else {
            // Do not end editing.
            textField.placeholder = "Enter a city"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Function runs when search field editing stops.
        
        // Store search field text.
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        // Clear search field text.
        searchTextField.text = ""
    }
}

// MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        
        DispatchQueue.main.async {
            
            let icon = weather.icon
            
            if icon.contains("n") {
                self.conditionImageView.image = UIImage.init(systemName: weather.nightConditionName)
            } else if icon.contains("d") {
                self.conditionImageView.image = UIImage.init(systemName: weather.dayConditionName)
            }
            
            self.temperatureLabel.text = weather.temperatureString
            self.descriptionLabel.text = weather.description
            self.cityLabel.text = weather.cityName
            print(weather.description)
        }
        
    }
    
    func didFailWithError(error: Error) {
        
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        
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
