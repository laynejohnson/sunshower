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
        getWeather(city: cityName)
    }
}

// MARK: - HueViewControllerDelegate

extension WeatherViewController: HueViewControllerDelegate {
    
    func didChangeDefaultButtonImage(button: UIButton, imageName: String) {

        if let image = UIImage(named: imageName) {
            button.setImage(image, for: .highlighted)
        }
    }
    
    func didChangeHighlightedButtonImage(button: UIButton, imageName: String) {

        if let image = UIImage(named: imageName) {
            button.setImage(image, for: .highlighted)
        }
    }

    func didChangeUIImage(imageView: UIImage, imageName: String) {
        if let image = UIImage(named: imageName) {
            imageView.image = UIImage(named: imageName)
        }
    }
    
    func hueChosen(hueCode: Int) {
        
        switch hueCode {
        case 1:
            print("Cotton candy sky chosen")
            
            // CHANGE BUTTONS
            // Set location button image
            if let locationButtonImage = UIImage(named: "location_icon_pink") {
                locationButton.setImage(locationButtonImage, for: .highlighted)
            }
            
            // Set search button
            if let searchButtonImage = UIImage(named: "search_icon_pink") {
                searchButton.setImage(searchButtonImage, for: .highlighted)
            }
            // Set hue button
            if let hueButtonImage = UIImage(named: "hue_icon_pink") {
                hueButton.setImage(hueButtonImage, for: .highlighted)
            }
            
            // CHANGE TEMP UI
        
            lowTempImage.image = UIImage(named: "other_temp_halo_pink")
            currentTempImage.image = UIImage(named: "current_temp_halo_pink")
            highTempImage.image = UIImage(named: "other_temp_halo_pink")
        
            // CHANGE FAVORITES UI
            // Change default state image
            // Change highlighted state image
            
            if let firstFavNormal = UIImage(named: "montreal_fav_pink") {
                firstFavoriteButton.setImage(firstFavNormal, for: .normal)
            }
            
            if let firstFavHighlight = UIImage(named: "montreal_fav_pink_highlight") {
                firstFavoriteButton.setImage(firstFavHighlight, for: .highlighted)
            }
       
//
//            secondFavoriteButton.setImage(<#T##image: UIImage?##UIImage?#>, for: .normal)
//            secondFavoriteButton.setImage(<#T##image: UIImage?##UIImage?#>, for: .highlighted)
//
//            thirdFavoriteButton.setImage(<#T##image: UIImage?##UIImage?#>, for: .normal)
//            thirdFavoriteButton.setImage(<#T##image: UIImage?##UIImage?#>, for: .highlighted)
//
//            fourthFavoriteButton.setImage(<#T##image: UIImage?##UIImage?#>, for: .normal)
//            fourthFavoriteButton.setImage(<#T##image: UIImage?##UIImage?#>, for: .highlighted)
    
        case 2:
            print("Fine day chosen")
            
            // Set location button image
            if let locationButtonImage = UIImage(named: "location_icon_blue") {
                locationButton.setImage(locationButtonImage, for: .highlighted)
            }
            
            // Set search button
            if let searcButtonImage = UIImage(named: "search_icon_blue") {
                searchButton.setImage(searcButtonImage, for: .highlighted)
            }
            // Set hue button
            if let hueButtonImage = UIImage(named: "hue_icon_blue") {
                hueButton.setImage(hueButtonImage, for: .highlighted)
            }
        case 3:
            print("Sunshine chosen")
            
        case 4:
            print("Sunshower chosen")
            
        default:
            print("Hello, I am the default hue")
            
            // Set location button image
            if let locationButtonImage = UIImage(named: "location_icon_default") {
                locationButton.setImage(locationButtonImage, for: .highlighted)
            }
            
            // Set search button
            if let searcButtonImage = UIImage(named: "search_icon_default") {
                searchButton.setImage(searcButtonImage, for: .highlighted)
            }
            // Set hue button
            if let hueButtonImage = UIImage(named: "hue_icon_default") {
                hueButton.setImage(hueButtonImage, for: .highlighted)
            }
        }
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
