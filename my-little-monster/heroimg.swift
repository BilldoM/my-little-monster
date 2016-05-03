//
//  heroimg.swift
//  my-little-monster
//
//  Created by William Melvin on 5/2/16.
//  Copyright © 2016 William Melvin. All rights reserved.
//

import Foundation
import UIKit

class HeroImg: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdlehAnimation()
    }
    
    func playIdlehAnimation() {
        
        self.image = UIImage(named: "idleh1.png")
        
        self.animationImages = nil
        
        
        var imageArray = [UIImage]()
        for x in 1..<4 {
            let img = UIImage(named: "idleh\(x).png")
            imageArray.append(img!)
        }
        
        self.animationImages = imageArray
        self.animationDuration = 0.75
        self.animationRepeatCount = 0
        self.startAnimating()
        
    }
    
    func playDeathhAnimation() {
        
        self.image = UIImage(named: "deadh5.png")
        
        self.animationImages = nil
        
        var imageArray = [UIImage]()
        for x in 1..<5 {
            let img = UIImage(named: "deadh\(x).png")
            imageArray.append(img!)
        }
        
        self.animationImages = imageArray
        self.animationDuration = 0.85
        self.animationRepeatCount = 1
        self.startAnimating()
        
    }
    
    
}

