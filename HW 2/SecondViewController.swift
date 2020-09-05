//
//  ViewController.swift
//  HW 2
//
//  Created by Alexey Efimov on 12.06.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    var delegate: SecondViewControllerDelegate!
    
    var red: Float!
    var green: Float!
    var blue: Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        setColor(red, green, blue)
        setValue(for: redLabel, greenLabel, blueLabel)
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    // Изменение цветов слайдерами
    @IBAction func rgbSlider(_ sender: UISlider) {
        switch sender.tag {
        case 0: labelsAndTextFields(sender, redLabel, redTextField)
        red = redSlider.value
        case 1: labelsAndTextFields(sender, greenLabel, greenTextField)
        green = greenSlider.value
        case 2: labelsAndTextFields(sender, blueLabel, blueTextField)
        blue = blueSlider.value
        default: break
        }
        setColor(red, green, blue)
    }
    
    // Кнопка Done
    @IBAction func done() {
        delegate.setMainVCColor(red: redSlider.value,
                                green: greenSlider.value,
                                blue: blueSlider.value)
        dismiss(animated: true)
    }
    
    // Цвет вью
    func setColor(_ red: Float, _ green: Float, _ blue: Float) {
        colorView.backgroundColor = UIColor(red: CGFloat(red),
                                            green: CGFloat(green),
                                            blue: CGFloat(blue),
                                            alpha: 1)
        redSlider.setValue(red, animated: false)
        greenSlider.setValue(green, animated: false)
        blueSlider.setValue(blue, animated: false)
    }
    
    // Установка значений Label и TextField
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label.tag {
            case 0: labelsAndTextFields(redSlider, label, redTextField)
            case 1: labelsAndTextFields(greenSlider, label, greenTextField)
            case 2: labelsAndTextFields(blueSlider, label, blueTextField)
            default: break
            }
        }
    }
    
    // Значения полей
    private func labelsAndTextFields(_ slider: UISlider, _ label: UILabel, _ text: UITextField) {
        label.text = string(from: slider)
        text.text = label.text
    }
    // Значения RGB
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension SecondViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0: red = Float(textField.text!)
        redSlider.setValue(red, animated: true)
        case 1: green = Float(textField.text!)
        greenSlider.setValue(green, animated: true)
        case 2: blue = Float(textField.text!)
        blueSlider.setValue(blue, animated: true)
        default:
            break
        }
        setColor(red, green, blue)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == redTextField {
            textField.resignFirstResponder()
            greenTextField.becomeFirstResponder()
        } else if textField == greenTextField {
            textField.resignFirstResponder()
            blueTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            done()
        }
        return true
    }
}
