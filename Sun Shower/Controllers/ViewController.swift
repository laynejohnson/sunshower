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
// TODO:

Refactor:
 // TODO:
 
 */

import UIKit

// UITextFieldDelegate allow our view controller to manage the editing and validation of text field

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets
        
    // ---------------------------------- //
    // - - - - - - -  OUTLETS - - - - - - //
    // ---------------------------------- //

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - Properties
        
    // ---------------------------------- //
    // - - - - - - - - VARS - - - - - - - //
    // ---------------------------------- //
    
    var weatherManager = WeatherManager()
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UITextField will notify view controller delegate; self == current view controller
        searchTextField.delegate = self
        
    }
    
    // MARK: - IBActions
        
    // ---------------------------------- //
    // - - - - - - - ACTIONS - - - - - -  //
    // ---------------------------------- //

    @IBAction func searchPressed(_ sender: Any) {
        // Dismiss keyboard
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    // MARK: - Delegate Methods
    
    // ---------------------------------- //
    // - - - - - - - DELEGATE - - - - - - //
    // ---------------------------------- //
    
    // Function enables return key on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss keyboard
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // Validate entry
        if textField.text != "" {
            // Should end editing
            return true
        } else {
            // Do not end editing
            textField.placeholder = "Enter a city"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Function runs when search field editing stops
        
        // Store search field text
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        // Clear search field text
        searchTextField.text = ""
    }
    
}

// MARK: - Functions
    
// ---------------------------------- //
// - - - - - - - - FUNC - - - - - - - //
// ---------------------------------- //



