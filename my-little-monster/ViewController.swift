//
//  ViewController.swift
//  my-little-monster
//
//  Created by William Melvin on 4/11/16.
//  Copyright © 2016 William Melvin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImage: DragImg!
    @IBOutlet weak var heartImage: DragImg!
    @IBOutlet weak var penaltyImg: UIImageView!
    @IBOutlet weak var penaltyImg2: UIImageView!
    @IBOutlet weak var penaltyImg3: UIImageView!

    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        foodImage.dropTarget = monsterImg
        heartImage.dropTarget = monsterImg
        
        penaltyImg.alpha = DIM_ALPHA
        penaltyImg2.alpha = DIM_ALPHA
        penaltyImg3.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
    
        startTimer()
        
    }
    
    
    
    func itemDroppedOnCharacter(notif: AnyObject) {
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        
        penalties = penalties + 1
        
        if penalties == 1 {
            penaltyImg.alpha = OPAQUE
            penaltyImg2.alpha = DIM_ALPHA
        } else if penalties == 2 {
            penaltyImg2.alpha = OPAQUE
            penaltyImg3.alpha = DIM_ALPHA
        } else if penalties >= 3 {
            penaltyImg3.alpha = OPAQUE
        } else {
            penaltyImg.alpha = DIM_ALPHA
            penaltyImg2.alpha = DIM_ALPHA
            penaltyImg3.alpha = DIM_ALPHA
        }
        
        if penalties >= MAX_PENALTIES {
            gameOver()
        }
        
        
    }
    
    func gameOver() {
        timer.invalidate()
        monsterImg.playDeathAnimation()
    }

}

