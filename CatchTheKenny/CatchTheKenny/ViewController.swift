//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Joseph Nguyen on 5/1/24.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    // VIEWS
    @IBOutlet weak var timeLimitLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        // HIGH SCORE CHECK
        let savedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if savedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = savedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        // IMAGES
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let recogniser1 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recogniser2 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recogniser3 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recogniser4 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recogniser5 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recogniser6 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recogniser7 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recogniser8 = UITapGestureRecognizer(target: self, action: #selector(addScore))
        let recogniser9 = UITapGestureRecognizer(target: self, action: #selector(addScore))

        kenny1.addGestureRecognizer(recogniser1)
        kenny2.addGestureRecognizer(recogniser2)
        kenny3.addGestureRecognizer(recogniser3)
        kenny4.addGestureRecognizer(recogniser4)
        kenny5.addGestureRecognizer(recogniser5)
        kenny6.addGestureRecognizer(recogniser6)
        kenny7.addGestureRecognizer(recogniser7)
        kenny8.addGestureRecognizer(recogniser8)
        kenny9.addGestureRecognizer(recogniser9)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        // TIME LIMIT
        counter = 30
        timeLimitLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeReduction), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
        
    }
    
    @objc func hideKenny() {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
        
    }
    
    @objc func addScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func timeReduction() {
        
        counter -= 1
        timeLimitLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            // HIGH SCORE
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            // ALERT
            let alert = UIAlertController(title: "TIME'S UP", message: "Do you want play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                // REPLAY
                self.score = 0
                self.scoreLabel.text = "Score \(self.score)"
                self.counter = 30
                self.timeLimitLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeReduction), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }


}

