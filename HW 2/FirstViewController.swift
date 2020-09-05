//
//  firstViewController.swift
//  HW 2
//
//  Created by Denis Svetlakov on 04.09.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit

protocol SecondViewControllerDelegate {
    func setMainVCColor (red: Float, green: Float, blue: Float)
}


class FirstViewController: UIViewController {
    
    public var red: Float = 1.0
    public var green: Float = 1.0
    public var blue: Float = 1.0
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! SecondViewController
        secondVC.delegate = self
        secondVC.red = red
        secondVC.green = green
        secondVC.blue = blue
    }
}

extension FirstViewController: SecondViewControllerDelegate{
    
    func setMainVCColor(red: Float, green: Float, blue: Float) {
        self.red = red
        self.green = green
        self.blue = blue
        view.backgroundColor = UIColor(red: CGFloat(red),
                                       green:CGFloat(green),
                                       blue: CGFloat(blue),
                                       alpha: 1)
    }
}

