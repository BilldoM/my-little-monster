//
//  ViewController.swift
//  my-little-monster
//
//  Created by William Melvin on 4/11/16.
//  Copyright © 2016 William Melvin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImage: DragImg!
    @IBOutlet weak var heartImage: DragImg!
    @IBOutlet weak var penaltyImg: UIImageView!
    @IBOutlet weak var penaltyImg2: UIImageView!
    @IBOutlet weak var penaltyImg3: UIImageView!
    @IBOutlet weak var playAgainBtn: Button!
    

    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    var penalties = 0
    var timer: NSTimer!
    
    var monsterHappy = false
    var currentItem: UInt32 = 0
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameStateBegining()
        
        
    }
    
    func gameStateBegining() {
        
        hideLabels()
        monsterHappy = false
        
        monsterImg.playIdleAnimation()
        foodImage.dropTarget = monsterImg
        heartImage.dropTarget = monsterImg
        
        penaltyImg.alpha = DIM_ALPHA
        penaltyImg2.alpha = DIM_ALPHA
        penaltyImg3.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        startTimer()
    }

    
    
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        monsterHappy = true
        startTimer()
        
        foodImage.alpha = DIM_ALPHA
        foodImage.userInteractionEnabled = false
        heartImage.alpha = DIM_ALPHA
        heartImage.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
        
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        
        if !monsterHappy {
            
            penalties = penalties + 1
            
            sfxSkull.play()
            
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
        
        let rand = arc4random_uniform(2) // 0 or 1
        
        if rand == 0 {
            foodImage.alpha = DIM_ALPHA
            foodImage.userInteractionEnabled = false
            
            heartImage.alpha = OPAQUE
            heartImage.userInteractionEnabled = true
        } else {
            heartImage.alpha = DIM_ALPHA
            heartImage.userInteractionEnabled = false
            
            foodImage.alpha = OPAQUE
            foodImage.userInteractionEnabled = true
        }
        
        currentItem = rand
        monsterHappy = false
        
    }
    
    
    func hideLabels() {
        playAgainBtn.hidden = true
        playAgainBtn.center = CGPointMake(playAgainBtn.center.x - 500, playAgainBtn.center.y)
    }

    @IBAction func onPressResetGame(sender: AnyObject) {
        musicPlayer.stop()
        
        
        
    }
    
    func gameOver() {
        timer.invalidate()
        monsterImg.playDeathAnimation()
        sfxDeath.play()
        
        
        playAgainBtn.hidden = false
        UIView.animateWithDuration(1.0, animations: { () -> Void in
           self.playAgainBtn.center = CGPointMake(self.playAgainBtn.center.x + 500, self.playAgainBtn.center.y)
        })

    }




}