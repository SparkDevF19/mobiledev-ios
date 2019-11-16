//
//  StyleFields.swift
//  Ticketing
//
//  Created by Reiner Gonzalez on 11/15/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation
import UIKit

class StyleFields{
    
    static func styleTextField(_ textField: UITextField){
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 100/255, green: 210/255, blue: 255/255, alpha: 1).cgColor
        
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
    
    static func styleButtonColor(_ button: UIButton){
        button.backgroundColor = UIColor.init(red: 100/255, green: 210/255, blue: 255/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
}

extension UIView {
    
    func errorShake() {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: self.center.x - 5.0, y: self.center.y)
        animation.toValue = CGPoint(x: self.center.x + 5.0, y: self.center.y)
        self.layer.add(animation, forKey: "position")
    }
}
