//
//  PickTeam.swift
//  MC7-Camp
//
//  Created by Paula Leite on 10/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import SpriteKit

class PickTeam: SKScene {
    var backButton = MenuButtonNode()
    var buttons = [MenuButtonNode]()
    var flags = [MenuButtonNode]()
    
    var numberOfPlayers = Int()
    var colorName = [String]()
    
    var flag1 = MenuButtonNode()
    var flag2 = MenuButtonNode()
    var flag3 = MenuButtonNode()
    var nameOfFlags = [String]()
    
    override func didMove(to view: SKView) {
        print("Inside Pick Team.")
        setupBackground()
        setupUIButtons()
        
        numberOfPlayers = 2
        colorName = ["white", "white", "white"]
        setupFlags(numberOfPlayers: numberOfPlayers)
        
        addTapGestureRecognizer()
    }
    
    func setupFlags(numberOfPlayers: Int) {
        var i = 0
        let nameFlag = "flag"
        while(i < numberOfPlayers) {
            let colorFlag = nameFlag + "\(i + 1)"
            nameOfFlags.append(colorFlag)
            i = i + 1
        }
        
        if numberOfPlayers == 2 {
            flag1 = MenuButtonNode(name: nameOfFlags[0])
            flag1.position = CGPoint(x: 1035, y: 700)
            flag1.zPosition = 0
            addChild(flag1)
            flags.append(flag1)
            
            flag2 = MenuButtonNode(name: nameOfFlags[1])
            flag2.position = CGPoint(x: 1035, y: 470.5)
            flag2.zPosition = 0
            addChild(flag2)
            flags.append(flag2)
        } else {
            flag1 = MenuButtonNode(name: nameOfFlags[0])
            flag1.position = CGPoint(x: 1035, y: 700)
            flag1.zPosition = 0
            addChild(flag1)
            flags.append(flag1)
            
            flag2 = MenuButtonNode(name: nameOfFlags[1])
            flag2.position = CGPoint(x: 1035, y: 470.5)
            flag2.zPosition = 0
            addChild(flag2)
            flags.append(flag2)
            
            flag3 = MenuButtonNode(name: nameOfFlags[2])
            flag3.position = CGPoint(x: 1035, y: 263)
            flag3.zPosition = 0
            addChild(flag3)
            flags.append(flag3)
        }

        for flag in flags {
            flag.isUserInteractionEnabled = true
        }
    }
    
    func setupUIButtons() {
        backButton = MenuButtonNode(name: "backButton")
        backButton.position = CGPoint(x: 90, y: 102.5)
        backButton.zPosition = 0
        addChild(backButton)
        buttons.append(backButton)
        
        for button in buttons {
            button.isUserInteractionEnabled = true
        }
    }
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "pickTeamBackground")
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
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
                print("Could not make Game Choices, check the name is spelled correctly")
                loadScreens(scene: scene)
            } else if focussedItem == flag1 {
                print("Flag 1 selected")
            } else if focussedItem == flag2 {
                print("Flag 2 selected")
            } else {
                print("Flag 3 selected")
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
