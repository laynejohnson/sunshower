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
 // TODO: Refine color palette
 // TODO: Units toggle (tap to change unit)
 // TODO: Add loading/fetching progress circle/animation (fetching weather)
 // TODO: Implement favorites feature (hard coded now)
 // TODO: Implement city entry validation e.g. city not found
 // TODO: Adjust text sizing for labels (auto)
 // TODO: Change navigation header color in hue chooser before segue
 
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
    
    // Icon Stack
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var hueButton: UIButton!
    
    // Weather View
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var textStackView: UIStackView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // Temperature View
    // Halos
    @IBOutlet weak var lowTempImage: UIImageView!
    @IBOutlet weak var currentTempImage: UIImageView!
    @IBOutlet weak var highTempImage: UIImageView!
    
    // Labels
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    
    // Favorites View (temp setup)
    @IBOutlet weak var firstFavoriteButton: UIButton!
    @IBOutlet weak var secondFavoriteButton: UIButton!
    @IBOutlet weak var thirdFavoriteButton: UIButton!
    @IBOutlet weak var fourthFavoriteButton: UIButton!
    
    // MARK: - Variables
    
    // ---------------------------------- //
    // - - - - - - - - VARS - - - - - - - //
    // ---------------------------------- //
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    //    var hue: Int = 0
    
    // MARK: - View Controller Life Cycle Methods
    
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
        
    }
    
    @IBAction func firstFavoritePressed(_ sender: UIButton) {
        weatherManager.fetchWeather(cityName: "Montreal")
    }
    
    @IBAction func secondFavoritePressed(_ sender: UIButton) {
        weatherManager.fetchWeather(cityName: "Austin")
    }
    
    @IBAction func thirdFavoritePressed(_ sender: UIButton) {
        weatherManager.fetchWeather(cityName: "Quito")
    }
    
    @IBAction func fourthFavoritePressed(_ sender: UIButton) {
        weatherManager.fetchWeather(cityName: "Catanzaro")
    }
    
    // MARK: - Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is SearchViewController {
            let destination = segue.destination as! SearchViewController
            destination.delegate = self
        } else if segue.destination is HueViewController {
            let destination = segue.destination as! HueViewController
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
        
        UIView.animate(withDuration: 0.6) {
            self.locationButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }
        
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

// MARK: - SearchViewControllerDelegate

extension WeatherViewController: SearchViewControllerDelegate {
    
    func searchPerformed(cityName: String) {
        print("This is city from stubFunc: \(cityName)")
        weatherManager.fetchWeather(cityName: cityName)
        
    }
}

// MARK: - HueViewControllerDelegate

extension WeatherViewController: HueViewControllerDelegate {
    
    func transformHue(hue: String, backgroundColor: UIColor, barTint: UIColor) {
        
        DispatchQueue.main.async { [self] in
            
        // Change background color
        backgroundView.backgroundColor = backgroundColor
        
        // Change navigation bar color
        navigationController?.navigationBar.barTintColor = backgroundColor
        
        // CHANGE BUTTONS
        // Set location button image
        changeHighlightedButtonImage(button: locationButton, imageName: "location_icon_\(hue)")
        
        // Set search button
        changeHighlightedButtonImage(button: searchButton, imageName: "search_icon_\(hue)")
        
        // Set hue button
        changeHighlightedButtonImage(button: hueButton, imageName: "hue_icon_\(hue)")
        
        // CHANGE TEMP UI
        
        lowTempImage.image = UIImage(named: "other_temp_\(hue)")
        currentTempImage.image = UIImage(named: "current_temp_\(hue)")
        highTempImage.image = UIImage(named: "other_temp_\(hue)")
        
        // CHANGE FAVORITES UI
        
        changeDefaultButtonImage(button: firstFavoriteButton, imageName: "montreal_fav_\(hue)")
        changeHighlightedButtonImage(button: firstFavoriteButton, imageName: "montreal_fav_\(hue)_highlight")
        
        changeDefaultButtonImage(button: secondFavoriteButton, imageName: "austin_fav_\(hue)")
        changeHighlightedButtonImage(button: secondFavoriteButton, imageName: "austin_fav_\(hue)_highlight")
        
        changeDefaultButtonImage(button: thirdFavoriteButton, imageName: "quito_fav_\(hue)")
        changeHighlightedButtonImage(button: thirdFavoriteButton, imageName: "quito_fav_\(hue)_highlight")
        
        changeDefaultButtonImage(button: fourthFavoriteButton, imageName: "catanzaro_fav_\(hue)")
        changeHighlightedButtonImage(button: fourthFavoriteButton, imageName: "catanzaro_fav_\(hue)_highlight")
    }
}
    func changeDefaultButtonImage(button: UIButton, imageName: String) {
        
        if let image = UIImage(named: imageName) {
            button.setImage(image, for: .normal)
        }
    }
    
    func changeHighlightedButtonImage(button: UIButton, imageName: String) {
        
        if let image = UIImage(named: imageName) {
            button.setImage(image, for: .highlighted)
        }
    }
}

// MARK: - String Struct Extension

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
