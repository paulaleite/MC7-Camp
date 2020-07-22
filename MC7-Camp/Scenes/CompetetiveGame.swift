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

class CompetetiveGame: SKScene {
    var teamPerson = [Int]()
    var teamWon = Int()
    var playersThatWon = [Int]()
    var winningPlayers = [Int]()
    
    var backButton = MenuButtonNode()
    var confirmButton = MenuButtonNode()
    
    var buttons = [MenuButtonNode]()
    var buttonNames = [String]()
    
    var beginGameButton = MenuButtonNode()
    var popUpBackground = SKSpriteNode()
    var explanationLabel = SKLabelNode()
    
    var context: NSManagedObjectContext?
    var coreDataManager: CoreDataManager?
    
    override func didMove(to view: SKView) {
        print("Inside Competitive Game.")
        print(teamPerson)
        setupBackground()
        setupUIButtons()
        popUpExplanation()
        
        addTapGestureRecognizer()
    }
    
    func popUpExplanation() {
        popUpBackground = SKSpriteNode(imageNamed: "popUpSpace")
        popUpBackground.position = CGPoint(x: 960, y: 540)
        popUpBackground.zPosition = 1
        addChild(popUpBackground)
        
        explanationLabel.fontColor = .black
        explanationLabel.fontSize = 60
        explanationLabel.numberOfLines = 0
        explanationLabel.text = "   Hoje nós vamos brincar de jogar\nroupa suja na cesta de basquete. Sua missão é\n   que o seu time consiga a maior\n    quantidade de cestas! Vamos lá?"
        explanationLabel.position = CGPoint(x: 960, y: 540)
        explanationLabel.zPosition = 2
        addChild(explanationLabel)
        
        beginGameButton = MenuButtonNode(name: "confirmuButton")
        beginGameButton.position = CGPoint(x: 960, y: 340)
        beginGameButton.zPosition = 2
        addChild(beginGameButton)
        
        beginGameButton.isUserInteractionEnabled = true
    }
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "mainBackground")
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
    }
    
    func setupUIButtons() {
        backButton = MenuButtonNode(name: "backButton")
        backButton.position = CGPoint(x: 90, y: 102.5)
        backButton.zPosition = 0
        addChild(backButton)
        backButton.isUserInteractionEnabled = true
    }
    
    func setupTeamButtons() {
        
        let quantity = "team"
        var i = 1
        while(i <= 2) {
            let quantityName = quantity + "\(i)"
            buttonNames.append(quantityName)
            
            i = i + 1
        }
        
        for i in 0 ..< 2 {
            let buttonSelected = MenuButtonNode(name: buttonNames[i])
            buttonSelected.position = CGPoint(x: 640 + (i * 640), y: 220)
            buttonSelected.zPosition = 1
            addChild(buttonSelected)
            buttonSelected.selectedTeam = i + 1
            buttons.append(buttonSelected)
        }
        
        for button in self.buttons {
            button.isUserInteractionEnabled = true
        }
    }
    
    func setupConfirmButton() {
        confirmButton = MenuButtonNode(name: "playButton")
        confirmButton.position = CGPoint(x: 1773, y: 186.5)
        confirmButton.zPosition = 0
        addChild(confirmButton)
        
        confirmButton.isUserInteractionEnabled = true
    }
    
    func saveRewardsCoreData(familyMemberIndexes: [Int]) {
        let application = UIApplication.shared.delegate as! AppDelegate
        
        context = application.persistentContainer.viewContext
        coreDataManager = CoreDataManager(context: context!)
        
        coreDataManager?.addToTimesPlayedBasketballGame(familyMemberIndexes: familyMemberIndexes, application: application)
        
        guard let amountOfTimesPlayed = coreDataManager?.fetchTimesPlayedBasketballGame(familyMemberIndexes: familyMemberIndexes) else {
            return
        }
        for i in 0 ..< familyMemberIndexes.count {
            
            // 1.0, 5.0, 10.0,
            let nameReward = "rewardBasketball"
            var rewardName = String()
            
            
            if Int(amountOfTimesPlayed[i]) % 5 == 0 {
                rewardName = nameReward + "\(amountOfTimesPlayed[i])"
                coreDataManager?.addRewardToFamilyMember(familyMemberIndex: familyMemberIndexes[i], rewardImageName: rewardName, application: application)
            } else if amountOfTimesPlayed[i] == 1.0 {
                rewardName = nameReward + "\(amountOfTimesPlayed[i])"
                coreDataManager?.addRewardToFamilyMember(familyMemberIndex: familyMemberIndexes[i], rewardImageName: rewardName, application: application)
            }
        }
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
                setupTeamButtons()
            } else if focussedItem == confirmButton {
                /* Load Game Won scene */
                guard let size = view?.frame.size else { return }
                let scene = GameWon(size: size)
                scene.playersThatWon = self.winningPlayers
                scene.game = "Competitive"
                scene.teamWon = self.teamWon
                saveRewardsCoreData(familyMemberIndexes: winningPlayers)
                loadScreens(scene: scene)
            } else if focussedItem == backButton {
                /* Load Game Choices scene */
                guard let size = view?.frame.size else { return }
                let scene = GameChoices(size: size)
                loadScreens(scene: scene)
            } else {
                for i in 0 ..< 2 {
                    let button = buttons[i]
                    if button != focussedItem {
                        continue
                    }
                    
                    for i in 0 ..< teamPerson.count {
                        if button.selectedTeam == 1 {
                            if teamPerson[i] == 1 {
                                self.winningPlayers.append(i)
                            }
                            self.teamWon = 1
                        } else {
                            if teamPerson[i] == 2 {
                                self.winningPlayers.append(i)
                            }
                            self.teamWon = 2
                        }
                    }
                    
                    setupConfirmButton()
                }
            }
            
            
        }
        print("tapped")
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
