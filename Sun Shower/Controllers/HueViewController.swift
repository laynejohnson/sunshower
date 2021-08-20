//
//  HueViewController.swift
//  Sun Shower
//
//  Created by Layne Johnson on 8/11/21.
//  Copyright © 2021. All rights reserved.

import UIKit

protocol HueViewControllerDelegate {
    
    func transformHue(hue: String, backgroundColor: UIColor, barTint: UIColor)
    
    func changeHueDefaultButtonImage(button: UIButton, imageName: String)

    func changeHueHighlightedButtonImage(button: UIButton, imageName: String)

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
        
        delegate?.transformHue(hue: "default", backgroundColor: #colorLiteral(red: 1, green: 0.9607843137, blue: 0.9450980392, alpha: 1), barTint: #colorLiteral(red: 1, green: 0.9607843137, blue: 0.9450980392, alpha: 1) )
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pinkHueSelected(_ sender: UIButton) {
        
        delegate?.transformHue(hue: "pink", backgroundColor: #colorLiteral(red: 1, green: 0.9647058824, blue: 0.9490196078, alpha: 1), barTint: #colorLiteral(red: 1, green: 0.9137254902, blue: 0.8745098039, alpha: 1) )
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func blueHueSelected(_ sender: UIButton) {
        
        delegate?.transformHue(hue: "blue", backgroundColor: #colorLiteral(red: 0.9764705882, green: 0.9960784314, blue: 1, alpha: 1), barTint: #colorLiteral(red: 0.9764705882, green: 0.9960784314, blue: 1, alpha: 1) )
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func yellowHueSelected(_ sender: UIButton) {
        
        delegate?.transformHue(hue: "yellow", backgroundColor: #colorLiteral(red: 1, green: 0.9607843137, blue: 0.9450980392, alpha: 1), barTint: #colorLiteral(red: 1, green: 0.9607843137, blue: 0.9450980392, alpha: 1) )
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sunshowerHueSelected(_ sender: UIButton) {
        
        delegate?.transformHue(hue: "sunshower", backgroundColor: #colorLiteral(red: 1, green: 0.9607843137, blue: 0.9450980392, alpha: 1), barTint: #colorLiteral(red: 1, green: 0.9607843137, blue: 0.9450980392, alpha: 1) )
        
        navigationController?.popViewController(animated: true)
    }
}
