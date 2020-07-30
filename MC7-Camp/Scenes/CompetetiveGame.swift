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
    var poles = [MenuButtonNode]()
    
    var beginGameButton = MenuButtonNode()
    var popUpBackground = SKSpriteNode()
    
    let defaults = UserDefaults.standard
    var context: NSManagedObjectContext?
    var coreDataManager: CoreDataManager?
    
    var explanationLabels = [SKLabelNode]()
    let playButtonLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
    
    var peopleInTeam2 = 0
    var peopleInTeam1 = 0
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupUIButtons()
        popUpExplanation()
        setupTexts()
        addTapGestureRecognizer()
    }
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "gameBackground")
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
    }
    
    func setupPoles() {
        amountOfPeopleInTeams()
        
        if peopleInTeam1 == 0 || peopleInTeam2 == 0 {
            let pole = MenuButtonNode(name: "pole")
            pole.size = CGSize(width: pole.size.width/2, height: pole.size.height/2)
            pole.position = CGPoint(x: 960, y: 470)
            pole.zPosition = 0
            addChild(pole)
        } else {
            for i in 0 ..< 2 {
                let pole = MenuButtonNode(name: "pole")
                pole.size = CGSize(width: pole.size.width/2, height: pole.size.height/2)
                pole.position = CGPoint(x: 780 + (i * 360), y: 470)
                pole.zPosition = 0
                addChild(pole)
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
    
    func amountOfPeopleInTeams() {
        for i in 0 ..< teamPerson.count {
            if teamPerson[i] == 2 {
                peopleInTeam2 += 1
            } else {
                peopleInTeam1 += 1
            }
        }
    }
    
    func setupTeamButtons() {
        
        let quantity = "team"
        var i = 1
        while(i <= 2) {
            let quantityName = quantity + "\(i)"
            buttonNames.append(quantityName)
            
            i = i + 1
        }
        
        amountOfPeopleInTeams()
        
        if peopleInTeam1 == 0 {
            let buttonSelected = MenuButtonNode(name: buttonNames[1])
            buttonSelected.position = CGPoint(x: 1072, y: 220)
            buttonSelected.zPosition = 1
            addChild(buttonSelected)
            buttonSelected.selectedTeam = 2
            buttons.append(buttonSelected)
        } else if peopleInTeam2 == 0 {
            let buttonSelected = MenuButtonNode(name: buttonNames[0])
            buttonSelected.position = CGPoint(x: 1072, y: 220)
            buttonSelected.zPosition = 1
            addChild(buttonSelected)
            buttonSelected.selectedTeam = 1
            buttons.append(buttonSelected)
        } else {
            for i in 0 ..< 2 {
                let buttonSelected = MenuButtonNode(name: buttonNames[i])
                buttonSelected.position = CGPoint(x: 892 + (i * 360), y: 220)
                buttonSelected.zPosition = 1
                addChild(buttonSelected)
                buttonSelected.selectedTeam = i + 1
                buttons.append(buttonSelected)
            }
        }
        
        for button in self.buttons {
            button.isUserInteractionEnabled = true
        }
    }
    
    func popUpExplanation() {
        popUpBackground = SKSpriteNode(imageNamed: "popUpBasketball")
        popUpBackground.position = CGPoint(x: 960, y: 540)
        popUpBackground.zPosition = 1
        addChild(popUpBackground)
        
        beginGameButton = MenuButtonNode(name: "confirmButton")
        beginGameButton.position = CGPoint(x: 960, y: 340)
        beginGameButton.zPosition = 2
        addChild(beginGameButton)
        
        beginGameButton.isUserInteractionEnabled = true
    }
    
    func setupTexts() {
        let backButtonLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
        backButtonLabel.fontColor = .black
        backButtonLabel.numberOfLines = 0
        backButtonLabel.fontSize = 60
        backButtonLabel.text = NSLocalizedString("Back_Button", comment: "Back button text.")
        backButtonLabel.position = CGPoint(x: 120, y: 110)
        backButtonLabel.zPosition = 1
        addChild(backButtonLabel)
        
        playButtonLabel.fontColor = .black
        playButtonLabel.numberOfLines = 0
        playButtonLabel.fontSize = 60
        playButtonLabel.text = NSLocalizedString("Play_Button", comment: "Play button text.")
        playButtonLabel.position = CGPoint(x: 1795, y: 105)
        playButtonLabel.zPosition = 1
        addChild(playButtonLabel)
        
        let explanationTexts = ["Competitive_Game_Explanation_1", "Competitive_Game_Explanation_2", "Competitive_Game_Explanation_3", "Competitive_Game_Explanation_4"]
        for i in 0 ..< explanationTexts.count {
            let competitiveGameExpLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
            competitiveGameExpLabel.fontColor = .black
            competitiveGameExpLabel.fontSize = 80
            competitiveGameExpLabel.text = NSLocalizedString(explanationTexts[i], comment: "Explains the Game.")
            competitiveGameExpLabel.position = CGPoint(x: 960, y: 850 - (i * 80))
            competitiveGameExpLabel.zPosition = 2
            addChild(competitiveGameExpLabel)
            self.explanationLabels.append(competitiveGameExpLabel)
        }
        
    }
    
    func setupConfirmText() {
        let confirmButtonLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
        confirmButtonLabel.fontColor = .black
        confirmButtonLabel.fontSize = 55
        confirmButtonLabel.text = NSLocalizedString("Confirm_Button", comment: "Confirm button text.")
        confirmButtonLabel.position = CGPoint(x: 1775, y: 120)
        confirmButtonLabel.zPosition = 1
        addChild(confirmButtonLabel)
    }
    
    func setupTextAfterGame() {
        let signForText = SKSpriteNode(imageNamed: "textSign")
        signForText.size = CGSize(width: self.size.width/2, height: self.size.height/4)
        signForText.position = CGPoint(x: 960, y: 950)
        signForText.zPosition = 0
        addChild(signForText)
        
        let chooseTeamWonLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
        chooseTeamWonLabel.fontColor = .black
        chooseTeamWonLabel.fontSize = 50
        chooseTeamWonLabel.text = NSLocalizedString("Ask_Team_Won", comment: "Asks about which team won.")
        chooseTeamWonLabel.position = CGPoint(x: 960, y: 980)
        chooseTeamWonLabel.zPosition = 1
        addChild(chooseTeamWonLabel)
    }
    
    func setupConfirmButton() {
        setupConfirmText()
        
        confirmButton = MenuButtonNode(name: "confirmButton2")
        confirmButton.size = CGSize(width: confirmButton.size.width/2.2, height: confirmButton.size.height/2.2)
        confirmButton.position = CGPoint(x: 1780, y: 120)
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
            
            if amountOfTimesPlayed[i] > 0.0 {
                if Int(amountOfTimesPlayed[i]) % 5 == 0 && amountOfTimesPlayed[i] <= 10.0 {
                    rewardName = nameReward + "\(amountOfTimesPlayed[i])"
                    coreDataManager?.addRewardToFamilyMember(familyMemberIndex: familyMemberIndexes[i], rewardImageName: rewardName, application: application)
                } else if amountOfTimesPlayed[i] == 1.0 {
                    rewardName = nameReward + "\(amountOfTimesPlayed[i])"
                    coreDataManager?.addRewardToFamilyMember(familyMemberIndex: familyMemberIndexes[i], rewardImageName: rewardName, application: application)
                }
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
                beginGameButton.removeFromParent()
                playButtonLabel.removeFromParent()
                for i in 0 ..< explanationLabels.count {
                    explanationLabels[i].removeFromParent()
                }
                setupTextAfterGame()
                setupTeamButtons()
                setupPoles()
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
                popUpBackground.removeFromParent()
                beginGameButton.removeFromParent()
                for i in 0 ..< explanationLabels.count {
                    explanationLabels[i].removeFromParent()
                }
                /* Load Game Choices scene */
                guard let size = view?.frame.size else { return }
                let scene = GameChoices(size: size)
                loadScreens(scene: scene)
            } else {
                for i in 0 ..< buttons.count {
                    let button = buttons[i]
                    if button != focussedItem {
                        continue
                    }
                    for i in 0 ..< teamPerson.count {
                        if button.selectedTeam == 1 {
                            if buttons.count > 1 {
                                if buttons[1].position.y == 780 {
                                    buttons[1].position.y = 220
                                }
                            }
                            if teamPerson[i] == 1 {
                                self.winningPlayers.append(i)
                            }
                            self.teamWon = 1
                            button.position.y = 780
                            
                            defaults.set(Date(timeIntervalSinceNow: 0), forKey: "LastPlayed")
                        } else if button.selectedTeam == 2 {
                            if buttons.count > 1 {
                                if buttons[0].position.y == 780 {
                                    buttons[0].position.y = 220
                                }
                            }
                            
                            if teamPerson[i] == 2 {
                                self.winningPlayers.append(i)
                            }
                            self.teamWon = 2
                            button.position.y = 780
                            
                            defaults.set(Date(timeIntervalSinceNow: 0), forKey: "LastPlayed")
                        }
                    }
                    setupConfirmButton()
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
        skView.showsFPS = false
        skView.showsNodeCount = false
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFill
        
        /* 4) Start game scene */
        skView.presentScene(scene)
    }
}
