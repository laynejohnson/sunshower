//
//  HueViewController.swift
//  Sun Shower
//
//  Created by Layne Johnson on 8/11/21.
//  Copyright © 2021. All rights reserved.

import UIKit

// TODO: Deselect all buttons when one selector selected

protocol HueViewControllerDelegate {
    
    func didChangeHue(hue: String, backgroundColor: UIColor, barTint: UIColor)
    
}

class HueViewController: UIViewController {
    
    @IBOutlet weak var defaultHueButton: UIButton!
    @IBOutlet weak var pinkHueButton: UIButton!
    @IBOutlet weak var blueHueButton: UIButton!
    @IBOutlet weak var yellowHueButton: UIButton!
    @IBOutlet weak var sunshowerHueButton: UIButton!
    
    var delegate: HueViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func defaultHueSelected(_ sender: UIButton) {
        
        sender.isSelected = true
        
        let barTint = #colorLiteral(red: 1, green: 0.9725490196, blue: 0.9607843137, alpha: 1)
        let backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        navigationController?.navigationBar.barTintColor = barTint
        
        delegate?.didChangeHue(hue: "default", backgroundColor: backgroundColor, barTint: barTint)
        
    }
    
    @IBAction func pinkHueSelected(_ sender: UIButton) {
        
        sender.isSelected = true
        
        let barTint = #colorLiteral(red: 1, green: 0.9647058824, blue: 0.9490196078, alpha: 1)
        let backgroundColor = #colorLiteral(red: 1, green: 0.9647058824, blue: 0.9490196078, alpha: 1)
        
        navigationController?.navigationBar.barTintColor = barTint
        
        delegate?.didChangeHue(hue: "pink", backgroundColor: backgroundColor, barTint: barTint)
        
    }
    
    @IBAction func blueHueSelected(_ sender: UIButton) {
        
        sender.isSelected = true
        
        let barTint = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9803921569, alpha: 1)
        let backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9803921569, alpha: 1)
        
        navigationController?.navigationBar.barTintColor = barTint
        
        delegate?.didChangeHue(hue: "blue", backgroundColor: backgroundColor, barTint: barTint)
        
    }
    
    @IBAction func yellowHueSelected(_ sender: UIButton) {
        
        sender.isSelected = true
        
        let barTint = #colorLiteral(red: 1, green: 0.9921568627, blue: 0.9450980392, alpha: 1)
        let backgroundColor = #colorLiteral(red: 1, green: 0.9921568627, blue: 0.9450980392, alpha: 1)
        
        navigationController?.navigationBar.barTintColor = barTint
        
        delegate?.didChangeHue(hue: "yellow", backgroundColor: backgroundColor, barTint: barTint)
        
    }
    
    @IBAction func sunshowerHueSelected(_ sender: UIButton) {
        
        sender.isSelected = true
        
        let barTint = #colorLiteral(red: 1, green: 0.9803921569, blue: 0.9725490196, alpha: 1)
        let backgroundColor = #colorLiteral(red: 1, green: 0.9803921569, blue: 0.9725490196, alpha: 1)
        
        navigationController?.navigationBar.barTintColor = barTint
        
        delegate?.didChangeHue(hue: "sunshower", backgroundColor: backgroundColor, barTint: barTint)
        
    }
}
