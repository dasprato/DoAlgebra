//
//  ShakingLabel.swift
//  Simple Algebra Test
//
//  Created by Prato Das on 2017-08-17.
//  Copyright © 2017 Prato Das. All rights reserved.
//

import UIKit

class ShakingLabel: UILabel {
    func shakeLabel() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 20
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }
}
