//
//  GameChoices.swift
//  MC7-Camp
//
//  Created by Paula Leite on 08/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class GameChoices: SKScene {
    var buttons = [MenuButtonNode]()
    var backButton = MenuButtonNode()
    var messGameButton = MenuButtonNode()
    var ballGameButton = MenuButtonNode()
    var nameGameChosen = String()
    
    var backButtonLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
    var ballGameButtonLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
    var messGameButtonLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
    var chooseGameLabel = SKLabelNode(fontNamed: "Pompiere-Regular")

    override func didMove(to view: SKView) {
        setupBackground()
        setupButtons()
        setupTexts()
        addTapGestureRecognizer()
    }
    
    func setupTexts() {
        backButtonLabel.fontColor = .black
        backButtonLabel.numberOfLines = 0
        backButtonLabel.fontSize = 60
        backButtonLabel.text = NSLocalizedString("Back_Button", comment: "Back button text.")
        backButtonLabel.position = CGPoint(x: 120, y: 110)
        backButtonLabel.zPosition = 1
        addChild(backButtonLabel)
        
        ballGameButtonLabel.fontColor = .black
        ballGameButtonLabel.numberOfLines = 0
        ballGameButtonLabel.fontSize = 50
        ballGameButtonLabel.zRotation = .pi/12
        ballGameButtonLabel.text = NSLocalizedString("Basketball_Game_Button", comment: "Basketball Game button text.")
        ballGameButtonLabel.position = CGPoint(x: 800, y: 330)
        ballGameButtonLabel.zPosition = 1
        addChild(ballGameButtonLabel)
        
        messGameButtonLabel.fontColor = .black
        messGameButtonLabel.numberOfLines = 0
        messGameButtonLabel.fontSize = 50
        messGameButtonLabel.text = NSLocalizedString("Mess_Game_Button", comment: "Mess Game button text.")
        messGameButtonLabel.position = CGPoint(x: 1186.5, y: 320)
        messGameButtonLabel.zPosition = 1
        addChild(messGameButtonLabel)
        
        chooseGameLabel.fontColor = .black
        chooseGameLabel.fontSize = 80
        chooseGameLabel.numberOfLines = 0
        chooseGameLabel.text = NSLocalizedString("Ask_Choose_Game", comment: "Asks about which game the family will play.")
        chooseGameLabel.position = CGPoint(x: 960, y: 840)
        chooseGameLabel.zPosition = 1
        addChild(chooseGameLabel)
    }
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "chooseGameBackground")
        background.size = self.size
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
    }
    
    func setupButtons() {
        backButton = MenuButtonNode(name: "backButton")
        backButton.position = CGPoint(x: 120, y: 120)
        backButton.zPosition = 0
        addChild(backButton)
        buttons.append(backButton)
        
        ballGameButton = MenuButtonNode(name: "basketballGameButton")
        ballGameButton.position = CGPoint(x: 800, y: 300)
        ballGameButton.zPosition = 0
        addChild(ballGameButton)
        buttons.append(ballGameButton)
        
        messGameButton = MenuButtonNode(name: "messGameButton")
        messGameButton.position = CGPoint(x: 1186.5, y: 282)
        messGameButton.zPosition = 0
        addChild(messGameButton)
        buttons.append(messGameButton)
        
        for button in buttons {
            button.isUserInteractionEnabled = true
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
            if focussedItem == backButton {
                /* Load Main scene */
                guard let size = view?.frame.size else { return }
                let scene = MainMenu(size: size)
                loadScreens(scene: scene)
            } else if focussedItem == messGameButton {
                /* Load Pick Team scene */
                guard let size = self.view?.frame.size else { return }
                let scene = PickPlayers(size: size)
                scene.nameGameChosen = "Basquete"
                loadScreens(scene: scene)
                
            } else {
                /* Load Pick Players scene */
                guard let size = self.view?.frame.size else { return }
                let scene = PickPlayers(size: size)
                scene.nameGameChosen = "Bagunca"
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
        
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFill
        
        /* 4) Start game scene */
        skView.presentScene(scene)
    }

}
