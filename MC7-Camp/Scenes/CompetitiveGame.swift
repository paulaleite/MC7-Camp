//
//  BallGame.swift
//  MC7-Camp
//
//  Created by Paula Leite on 10/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import SpriteKit

class CompetitiveGame: SKScene {
    var backButton = MenuButtonNode()
    var team1Won = MenuButtonNode()
    var team2Won = MenuButtonNode()
    
    var teamButtons = [MenuButtonNode]()
    
//    var buttons = [MenuButtonNode]()
    
    override func didMove(to view: SKView) {
        print("Inside Ball Game.")
        setupBackground()
        setupUIButtons()
        setupTeamButtons()
        
        addTapGestureRecognizer()
    }
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "gameIllustration")
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
    }
    
    func setupUIButtons() {
        backButton = MenuButtonNode(name: "backButton")
        backButton.position = CGPoint(x: 90, y: 102.5)
        backButton.zPosition = 0
        addChild(backButton)
//        buttons.append(backButton)
        
        backButton.isUserInteractionEnabled = true
    }
    
    func setupTeamButtons() {
        team1Won = MenuButtonNode(name: "team1")
        team1Won.position = CGPoint(x: 640, y: 220)
        team1Won.zPosition = 0
        addChild(team1Won)
        teamButtons.append(team1Won)
        
        team2Won = MenuButtonNode(name: "team2")
        team2Won.position = CGPoint(x: 1280, y: 220)
        team2Won.zPosition = 0
        addChild(team2Won)
        teamButtons.append(team2Won)
        
        for button in teamButtons {
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
                /* Load Game Choices scene */
                guard let size = view?.frame.size else { return }
                let scene = GameChoices(size: size)
                loadScreens(scene: scene)
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
