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

    override func didMove(to view: SKView) {
        setupBackground()
        setupButtons()
        addTapGestureRecognizer()
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
        
        messGameButton = MenuButtonNode(name: "basketballGameButton")
        messGameButton.position = CGPoint(x: 800, y: 300)
        messGameButton.zPosition = 0
        addChild(messGameButton)
        buttons.append(messGameButton)
        
        ballGameButton = MenuButtonNode(name: "messGameButton")
        ballGameButton.position = CGPoint(x: 1186.5, y: 282)
        ballGameButton.zPosition = 0
        addChild(ballGameButton)
        buttons.append(ballGameButton)
        
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
