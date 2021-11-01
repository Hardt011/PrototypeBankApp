//
//  degrade.swift
//  AppTesteBanco
//
//  Created by Virtual Machine on 11/10/21.
//

import Foundation
import UIKit


extension UIView {
    func gradientBackground (colorOne: UIColor , colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor , colorTwo.cgColor]
        gradientLayer.locations = [0.1 , 1.0]
        gradientLayer.startPoint = CGPoint (x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint (x: 1.0 , y:1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
