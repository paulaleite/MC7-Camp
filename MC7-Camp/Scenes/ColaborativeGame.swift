//
//  BallGame.swift
//  MC7-Camp
//
//  Created by Paula Leite on 10/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import SpriteKit
import CoreData

class ColaborativeGame: SKScene {
    var participating = [Int]()
    var amountCleaned = Int()
    
    var backButton = MenuButtonNode()
    var confirmButton = MenuButtonNode()
    
    var buttons = [MenuButtonNode]()
    var buttonNames = [String]()
    
    var beginGameButton = MenuButtonNode()
    var rejectGameButton = MenuButtonNode()
    var popUpBackground = SKSpriteNode()
    var explanationLabel = SKLabelNode()
    
    var totalSeconds = 299
    
    var timerLabel = SKLabelNode()
    
    var context: NSManagedObjectContext?
    var coreDataManager: CoreDataManager?
    
    let defaults = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupUIButtons()
        popUpExplanation()
        
        addTapGestureRecognizer()
    }
    
    func restartTimer(){
        
        let wait: SKAction = SKAction.wait(forDuration: 1)
        let finishTimer:SKAction = SKAction.run {
            
            self.timerLabel.text = String(self.totalSeconds)
            self.totalSeconds -= 1
            
            if self.totalSeconds >= 0 {
                self.restartTimer()
            } else {
                self.timerLabel.numberOfLines = 0
                self.timerLabel.text = "            Acabou o tempo! \nQuanto vocês conseguiram arrumar?"
                self.timerLabel.fontSize = 60
                self.setupMessButtons()
            }
            
        }
        
        let seq: SKAction = SKAction.sequence([wait, finishTimer])
        self.run(seq)
        
    }
    
    func popUpExplanation() {
        popUpBackground = SKSpriteNode(imageNamed: "popUpMess")
        popUpBackground.position = CGPoint(x: 960, y: 540)
        popUpBackground.zPosition = 1
        addChild(popUpBackground)
        
        beginGameButton = MenuButtonNode(name: "confirmButton")
        beginGameButton.position = CGPoint(x: 960, y: 340)
        beginGameButton.zPosition = 2
        addChild(beginGameButton)
        
        beginGameButton.isUserInteractionEnabled = true
    }
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "mainMenuBackground")
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
    }
    
    func setupTimer() {
        timerLabel.fontColor = .black
        timerLabel.fontSize = 120
        timerLabel.text = String(self.totalSeconds + 1)
        timerLabel.position = CGPoint(x: 960, y: 540)
        timerLabel.zPosition = 0
        addChild(timerLabel)
    }
    
    func saveRewardsCoreData(familyMemberIndexes: [Int]) {
        let application = UIApplication.shared.delegate as! AppDelegate
        
        context = application.persistentContainer.viewContext
        coreDataManager = CoreDataManager(context: context!)
        
        coreDataManager?.addToTimesPlayedMessGame(familyMemberIndexes: familyMemberIndexes, application: application)
        
        guard let amountOfTimesPlayed = coreDataManager?.fetchTimesPlayedMessGame(familyMemberIndexes: familyMemberIndexes) else {
            return
        }
        for i in 0 ..< familyMemberIndexes.count {
            
            // 1.0, 5.0, 10.0,
            let nameReward = "rewardMess"
            var rewardName = String()
            
            
            if Int(amountOfTimesPlayed[i]) % 5 == 0 {
                rewardName = nameReward + "\(amountOfTimesPlayed[i])"
                coreDataManager?.addRewardToFamilyMember(familyMemberIndex: i, rewardImageName: rewardName, application: application)
            } else if amountOfTimesPlayed[i] == 1.0 {
                rewardName = nameReward + "\(amountOfTimesPlayed[i])"
                coreDataManager?.addRewardToFamilyMember(familyMemberIndex: i, rewardImageName: rewardName, application: application)
            }
        }
    }
    
    func setupUIButtons() {
        backButton = MenuButtonNode(name: "backButton")
        backButton.position = CGPoint(x: 120, y: 120)
        backButton.zPosition = 0
        addChild(backButton)
        
        backButton.isUserInteractionEnabled = true
    }
    
    func setupMessButtons() {
        
        let quantity = "qtt"
        var i = 1
        while(i <= 3) {
            let quantityName = quantity + "\(i)"
            buttonNames.append(quantityName)
            
            i = i + 1
        }
        
        for i in 0 ..< 3 {
            let buttonSelected = MenuButtonNode(name: buttonNames[i])
            buttonSelected.position = CGPoint(x: 640 + (i * 320), y: 220)
            buttonSelected.zPosition = 1
            addChild(buttonSelected)
            buttons.append(buttonSelected)
        }
        
        for button in self.buttons {
            button.isUserInteractionEnabled = true
        }
    }
    
    func setupConfirmButton() {
        confirmButton = MenuButtonNode(name: "playButton")
        confirmButton.position = CGPoint(x: 1800, y: 120)
        confirmButton.zPosition = 0
        addChild(confirmButton)
        
        confirmButton.isUserInteractionEnabled = true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        let prevItem = context.previouslyFocusedItem
        let nextItem = context.nextFocusedItem
        
        if let prevButton = prevItem as? MenuButtonNode {
            prevButton.buttonDidLoseFocus()
        }
        
        if let nextButton = nextItem as? MenuButtonNode {
            nextButton.buttonDidGetFocus()
        }
    }
    
    func addTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        self.view?.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func tapped(sender: AnyObject) {
        if let focussedItem = UIScreen.main.focusedItem as? MenuButtonNode {
            if focussedItem == beginGameButton {
                popUpBackground.removeFromParent()
                explanationLabel.removeFromParent()
                beginGameButton.removeFromParent()
                setupTimer()
                restartTimer()
            } else if focussedItem == confirmButton {
                /* Load Game Won scene */
                guard let size = view?.frame.size else { return }
                let scene = GameWon(size: size)
                scene.amountCleaned = self.amountCleaned
                scene.game = "Collaborative"
                saveRewardsCoreData(familyMemberIndexes: participating)
                loadScreens(scene: scene)
            } else if focussedItem == backButton {
                /* Load Game Choices scene */
                guard let size = view?.frame.size else { return }
                let scene = GameChoices(size: size)
                loadScreens(scene: scene)
            } else {
                for i in 0 ..< 3 {
                    let button = buttons[i]
                    if button != focussedItem {
                        continue
                    }
                    self.amountCleaned = i
                    setupConfirmButton()
                }
                if amountCleaned == 0 {
                    defaults.set(Date(timeIntervalSinceNow: -518400), forKey: "LastPlayed")
                } else if amountCleaned == 1 {
                    defaults.set(Date(timeIntervalSinceNow: -259200), forKey: "LastPlayed")
                } else {
                    defaults.set(Date(timeIntervalSinceNow: 0), forKey: "LastPlayed")
                }
            }
            
            
        }
    }
    
    func loadScreens(scene: SKScene) {
        /* Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }
        
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFill
        
        /* Show debug */
        skView.showsPhysics = true
        skView.showsDrawCount = true
        skView.showsFPS = true
        
        /* 4) Start game scene */
        skView.presentScene(scene)
    }
}
