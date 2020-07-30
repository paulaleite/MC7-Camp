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
        
        let ballGameText = ["Basketball_Game_Button_Top", "Basketball_Game_Button_Bottom"]
        for i in 0 ..< ballGameText.count {
            let ballGameButtonLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
            ballGameButtonLabel.fontColor = .black
            ballGameButtonLabel.fontSize = 45
            ballGameButtonLabel.zRotation = .pi/12
            ballGameButtonLabel.text = NSLocalizedString(ballGameText[i], comment: "Basketball Game button text.")
            ballGameButtonLabel.position = CGPoint(x: 800, y: 420 - (i * 40))
            ballGameButtonLabel.zPosition = 1
            addChild(ballGameButtonLabel)
        }
        
        let messGameText = ["Mess_Game_Button_Top", "Mess_Game_Button_Bottom"]
        for i in 0 ..< messGameText.count {
            let messGameButtonLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
            messGameButtonLabel.fontColor = .black
            messGameButtonLabel.fontSize = 45
            messGameButtonLabel.text = NSLocalizedString(messGameText[i], comment: "Basketball Game button text.")
            messGameButtonLabel.position = CGPoint(x: 1186, y: 400 - (i * 40))
            messGameButtonLabel.zPosition = 1
            addChild(messGameButtonLabel)
        }
        
        let chooseGameLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
        chooseGameLabel.fontColor = .black
        chooseGameLabel.fontSize = 50
        chooseGameLabel.text = NSLocalizedString("Ask_Choose_Game", comment: "Asks about which game the family will play.")
        chooseGameLabel.position = CGPoint(x: 960, y: 980)
        chooseGameLabel.zPosition = 1
        addChild(chooseGameLabel)
    }
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "chooseGameBackground")
        background.size = self.size
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
        
        let signForText = SKSpriteNode(imageNamed: "textSign")
        signForText.size = CGSize(width: self.size.width/2, height: self.size.height/4)
        signForText.position = CGPoint(x: 960, y: 950)
        signForText.zPosition = 0
        addChild(signForText)
    }
    
    func setupButtons() {
        backButton = MenuButtonNode(name: "backButton")
        backButton.size = CGSize(width: backButton.size.width/8, height: backButton.size.height/8)
        backButton.position = CGPoint(x: 120, y: 120)
        backButton.zPosition = 0
        addChild(backButton)
        buttons.append(backButton)
        
        ballGameButton = MenuButtonNode(name: "basketballGameButton")
        ballGameButton.size = CGSize(width: ballGameButton.size.width/4, height: ballGameButton.size.height/4)
        ballGameButton.position = CGPoint(x: 800, y: 300)
        ballGameButton.zPosition = 0
        addChild(ballGameButton)
        buttons.append(ballGameButton)
        
        messGameButton = MenuButtonNode(name: "messGameButton")
        messGameButton.size = CGSize(width: messGameButton.size.width/4, height: messGameButton.size.height/4)
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
                scene.nameGameChosen = "Bagunca"
                loadScreens(scene: scene)
                
            } else {
                /* Load Pick Players scene */
                guard let size = self.view?.frame.size else { return }
                let scene = PickPlayers(size: size)
                scene.nameGameChosen = "Basquete"
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
