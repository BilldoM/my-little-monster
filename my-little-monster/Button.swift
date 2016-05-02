//
//  Button.swift
//  my-little-monster
//
//  Created by William Melvin on 5/2/16.
//  Copyright © 2016 William Melvin. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    override func awakeFromNib() {
        layer.cornerRadius = 5.0
        backgroundColor = UIColor(colorLiteralRed: 202.0/255.0, green: 168.0/255.0, blue: 138.0/255.0, alpha: 1.0)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
    }
    

}
