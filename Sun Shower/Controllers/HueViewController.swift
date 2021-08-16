//
//  HueViewController.swift
//  Sun Shower
//
//  Created by Layne Johnson on 8/11/21.
//  Copyright © 2021. All rights reserved.

import UIKit

 // TODO: Add theme assets
 // TODO: Config switch statement in weather view controller

protocol HueViewControllerDelegate {
    
    func changeHue(hueCode: Int)
    
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
        delegate?.changeHue(hueCode: 0)
    }
    
    @IBAction func pinkHueSelected(_ sender: UIButton) {
        delegate?.changeHue(hueCode: 1)
    }
    
    @IBAction func blueHueSelected(_ sender: UIButton) {
        delegate?.changeHue(hueCode: 2)
    }
    
    @IBAction func yellowHueSelected(_ sender: UIButton) {
        delegate?.changeHue(hueCode: 3)
      
    }
    
    @IBAction func sunshowerHueSelected(_ sender: UIButton) {
        delegate?.changeHue(hueCode: 4)
    }
}
