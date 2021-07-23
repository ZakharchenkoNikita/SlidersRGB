//
//  MainViewController.swift
//  SlidersRGB
//
//  Created by Nikita on 23.07.21.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setSmallViewColor(redSlider: CGFloat, greenSlider: CGFloat, blueSlider: CGFloat)
}

class MainViewController: UIViewController {

    var redSliderValue: Float = 1.0
    var greenSliderValue: Float = 1.0
    var blueSliderValue: Float = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        
        settingsVC.redSliderValue = redSliderValue
        settingsVC.greenSliderValue = greenSliderValue
        settingsVC.blueSliderValue = blueSliderValue
        
        settingsVC.delegate = self
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setSmallViewColor(redSlider: CGFloat, greenSlider: CGFloat, blueSlider: CGFloat) {
        view.backgroundColor = UIColor(red: redSlider, green: greenSlider, blue: blueSlider, alpha: 1)
        
        redSliderValue = Float(redSlider)
        greenSliderValue = Float(greenSlider)
        blueSliderValue = Float(blueSlider)
    }
}
