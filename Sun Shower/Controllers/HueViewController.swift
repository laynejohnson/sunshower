//
//  HueViewController.swift
//  Sun Shower
//
//  Created by Layne Johnson on 8/11/21.
//  Copyright © 2021. All rights reserved.

import UIKit

 // TODO: Add theme assets
 // TODO: Config switch statement in weather view controller

class HueViewController: UIViewController {
    
    var hue: Int = 0
    
    @IBOutlet weak var defaultHueButton: UIButton!
    @IBOutlet weak var pinkHueButton: UIButton!
    @IBOutlet weak var blueHueButton: UIButton!
    @IBOutlet weak var yellowHueButton: UIButton!
    @IBOutlet weak var sunshowerHueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func defaultHueSelected(_ sender: UIButton) {
        hue = 0
        print(hue)
    }
    
    @IBAction func pinkHueSelected(_ sender: UIButton) {
        hue = 1
        print(hue)
    }
    
    @IBAction func blueHueSelected(_ sender: UIButton) {
        hue = 2
        print(hue)
    }
    
    @IBAction func yellowHueSelected(_ sender: UIButton) {
        hue = 3
        print(hue)
    }
   
    @IBAction func sunshowerHueSelected(_ sender: UIButton) {
        hue = 4
        print(hue)
    }
}
