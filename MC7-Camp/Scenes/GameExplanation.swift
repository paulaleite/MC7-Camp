//
//  GameExplanation.swift
//  MC7-Camp
//
//  Created by Paula Leite on 18/08/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GameExplanation: SKScene {
    var popUpBackground = SKSpriteNode()
    
    var beginGameButton = MenuButtonNode()
    var backButton = MenuButtonNode()
    
    var explanationLabels = [SKLabelNode]()
    let playButtonLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
    
    var nameGameChosen = String()
    
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
    
    func setupUIButtons() {
        backButton = MenuButtonNode(name: "backButton")
        backButton.position = CGPoint(x: 120, y: 120)
        backButton.zPosition = 0
        addChild(backButton)
        backButton.isUserInteractionEnabled = true
    }
    
    func popUpExplanation() {
        popUpBackground = SKSpriteNode(imageNamed: "popUp")
        popUpBackground.position = CGPoint(x: 960, y: 540)
        popUpBackground.zPosition = 1
        addChild(popUpBackground)
        
        beginGameButton = MenuButtonNode(name: "playButton")
        beginGameButton.position = CGPoint(x: 1775, y: 120)
        beginGameButton.zPosition = 1
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
        playButtonLabel.zPosition = 2
        addChild(playButtonLabel)
        
        let explanationTextsBasketball = ["Competitive_Game_Explanation_1", "Competitive_Game_Explanation_2", "Competitive_Game_Explanation_3", "Competitive_Game_Explanation_4", "Competitive_Game_Explanation_5"]
        let explanationTextsMess = ["Colaborative_Game_Explanation_1", "Colaborative_Game_Explanation_2", "Colaborative_Game_Explanation_3", "Colaborative_Game_Explanation_4", "Colaborative_Game_Explanation_5"]
        
        if nameGameChosen == "Basquete" {
            settingExplanationTexts(texts: explanationTextsBasketball)
        } else if nameGameChosen == "Bagunca" {
            settingExplanationTexts(texts: explanationTextsMess)
        }
        
    }
    
    func settingExplanationTexts(texts: [String]) {
        for i in 0 ..< texts.count {
            let explanationLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
            explanationLabel.fontColor = .black
            explanationLabel.fontSize = 80
            explanationLabel.text = NSLocalizedString(texts[i], comment: "Explains the Game.")
            explanationLabel.position = CGPoint(x: 960, y: 850 - (i * 80))
            explanationLabel.zPosition = 2
            addChild(explanationLabel)
            self.explanationLabels.append(explanationLabel)
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
                /* Load Game scene */
                guard let size = view?.frame.size else { return }
                let scene = PickPlayers(size: size)
                scene.nameGameChosen = self.nameGameChosen
                loadScreens(scene: scene)
            } else if focussedItem == backButton {
                /* Load Game Choices scene */
                guard let size = view?.frame.size else { return }
                let scene = GameChoices(size: size)
                loadScreens(scene: scene)
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
