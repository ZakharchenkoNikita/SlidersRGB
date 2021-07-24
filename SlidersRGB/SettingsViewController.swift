//
//  SettingsViewController.swift
//  SlidersRGB
//
//  Created by Nikita on 09.07.21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: IB Outlets
    @IBOutlet weak var smallView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    @IBOutlet var rgbValueTF: [UITextField]!
    
    // MARK: properties
    var smallViewColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    var redSliderValue: Float!
    var greenSliderValue: Float!
    var blueSliderValue: Float!
    
    // MARK: override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        smallView.layer.cornerRadius = 20
        
        setupSliders()
        setupLabel(for: redValueLabel, greenValueLabel, blueValueLabel)
        setupTF()
        setColor()
    
        getDoneButtonOnKeyboard()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: IB Actions
    @IBAction func rgbSlider(_ sender: UISlider) {
        setColor()
        setupTF()
        
        switch sender {
        case redSlider: setupLabel(for: redValueLabel)
        case greenSlider: setupLabel(for: greenValueLabel)
        default: setupLabel(for: blueValueLabel)
        }
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setSmallViewColor(redSlider: CGFloat(redSlider.value),
                             greenSlider: CGFloat(greenSlider.value),
                             blueSlider: CGFloat(blueSlider.value))
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: private methods
extension SettingsViewController {
    private func setColor() {
        smallView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }
    
    private func setupLabel(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                label.text = getString(slider: redSlider)
            case greenValueLabel:
                label.text = getString(slider: greenSlider)
            default:
                label.text = getString(slider: blueSlider)
            }
        }
    }
    
    private func getString(slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setupSliders() {
        redSlider.minimumTrackTintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        greenSlider.minimumTrackTintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        blueSlider.minimumTrackTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        redSlider.value = redSliderValue
        greenSlider.value = greenSliderValue
        blueSlider.value = blueSliderValue
    }
    
    private func setupTF() {
        for tf in rgbValueTF {
            switch tf.tag {
            case 0: tf.text = getString(slider: redSlider)
            case 1: tf.text = getString(slider: greenSlider)
            default: tf.text = getString(slider: blueSlider)
            }
        }
    }
}

// MARK: working with keyboard
extension SettingsViewController: UITextFieldDelegate {
    
    private func getDoneButtonOnKeyboard() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        toolBar.items = [doneButton]
        
        for textField in rgbValueTF {
            textField.inputAccessoryView = toolBar
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
