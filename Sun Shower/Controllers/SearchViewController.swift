//
//  SearchViewController.swift
//  Sun Shower
//
//  Created by Layne Johnson on 8/11/21.
//  Copyright © 2021. All rights reserved.

import UIKit

protocol SearchViewControllerDelegate {
    
    func searchPerformed(cityName: String)
    
}

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var city: String = ""
    var delegate: SearchViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        // Dismiss keyboard.
        searchTextField.endEditing(true)
        
        delegate?.searchPerformed(cityName: city)
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITextFieldDelegate Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Dismiss keyboard
        searchTextField.endEditing(true)
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
        
        // Capture search field text
        if let searchCity = searchTextField.text {
            city = searchCity
        }
    }
}
