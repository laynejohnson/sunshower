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
 // TODO: Units toggle (Tap to change unit)
 // TODO: Add loading/fetching progress circle/animation (fetching weather)
 // Implement favorites feature (hard coded now)
 
 Refactor:
 // TODO:
 
 */

import UIKit
import CoreLocation

// MARK: - View Controller

class WeatherViewController: UIViewController, SearchViewControllerDelegate {
    
    func searchPerformed(cityName: String) {
        print("This is city from stubFunc: \(cityName)")
        getWeather(city: cityName)
    }
    
    
    // MARK: - IBOutlets
    
    // ---------------------------------- //
    // - - - - - - -  OUTLETS - - - - - - //
    // ---------------------------------- //
    
    // Icon Stack
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var colorThemeButton: UIButton!

    // Weather View
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var textStackView: UIStackView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
   
    // Temperature View
    // Halos
    @IBOutlet weak var lowTempHalo: UIImageView!
    @IBOutlet weak var currentTempHalo: UIImageView!
    @IBOutlet weak var highTempHalo: UIImageView!
    
    // Labels
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    
    // Favorites View (temp setup)
    @IBOutlet weak var firstFavorite: UIButton!
    @IBOutlet weak var secondFavorite: UIButton!
    @IBOutlet weak var thirdFavorite: UIButton!
    @IBOutlet weak var fourthFavorite: UIButton!
    
    // MARK: - Variables
    
    // ---------------------------------- //
    // - - - - - - - - VARS - - - - - - - //
    // ---------------------------------- //
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    var hue: Int = 0
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Hue switch statement here
        switch hue {
        case 1:
            print("pink selected")
        // Icon stack highlighted
        // Temp halos
        // Favorites
        case 2:
            print("blue selected")
        case 3:
            print("yellow selected")
        case 4:
            print("sunshower selected")
        default:
            print("hello, I am the default selection")
        }
    }
    
    // Favorites temp setup (hard coded)
    func getWeather(city: String) {
        weatherManager.fetchWeather(cityName: city)
    }
    
    @IBAction func montrealPressed(_ sender: UIButton) {
        getWeather(city: "Montreal")
    }
    
    @IBAction func austinPressed(_ sender: UIButton) {
        getWeather(city: "Austin")
    }
    
    @IBAction func parisPressed(_ sender: UIButton) {
        getWeather(city: "Paris")
    }
    
    @IBAction func nashvillePressed(_ sender: UIButton) {
        getWeather(city: "Nashville")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is SearchViewController {
            let destination = segue.destination as! SearchViewController
            destination.delegate = self
            
            
        }
   
    }
}
// End WeatherViewController



// MARK: - UI Functions

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
        locationManager.startUpdatingLocation()
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

//extension WeatherViewController: SearchViewControllerDelegate {
//
//    func searchPerformed(cityName: String) {
//        print("This is the city from stub function: \(cityName)")
//        getWeather(city: cityName)
//    }
//}

// MARK: - String Extension

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
