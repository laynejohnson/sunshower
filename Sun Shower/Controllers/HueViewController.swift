//
//  HueViewController.swift
//  Sun Shower
//
//  Created by Layne Johnson on 8/11/21.
//  Copyright © 2021. All rights reserved.

import UIKit

protocol HueViewControllerDelegate {
    
    func hueChosen(hueCode: Int)
    
    func didChangeDefaultButtonImage(button: UIButton, imageName: String)

    func didChangeHighlightedButtonImage(button: UIButton, imageName: String)

    func didChangeUIImage(imageView: UIImage, imageName: String)
    
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
        
        delegate?.hueChosen(hueCode: 0)
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pinkHueSelected(_ sender: UIButton) {
        
        delegate?.hueChosen(hueCode: 1)
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func blueHueSelected(_ sender: UIButton) {
        
        delegate?.hueChosen(hueCode: 2)
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func yellowHueSelected(_ sender: UIButton) {
        
        delegate?.hueChosen(hueCode: 3)
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sunshowerHueSelected(_ sender: UIButton) {
        
        delegate?.hueChosen(hueCode: 4)
        
        navigationController?.popViewController(animated: true)
    }
}
