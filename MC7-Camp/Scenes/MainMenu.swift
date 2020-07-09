//
//  MainMenu.swift
//  MC7-Camp
//
//  Created by Paula Leite on 08/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import UIKit
import SpriteKit

class MainMenu: SKScene {
    
    /* UI Connections */
    var buttons = [MenuButtonNode]()
    var shacks = [MenuButtonNode]()
    var numberOfPlayers = Int()
    var colorName = String()
    var playButton = MenuButtonNode()
    var configButton = MenuButtonNode()
    var shack1 = MenuButtonNode()
    var shack2 = MenuButtonNode()
    var shack3 = MenuButtonNode()
    var shack4 = MenuButtonNode()
    var shack5 = MenuButtonNode()
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        setupButtons()
        numberOfPlayers = 2
        colorName = "white"
        setupBackground(numberOfPlayers: numberOfPlayers, colorName: colorName)
        
        addTapGestureRecognizer()
        
    }
    
    func setupButtons() {
        playButton = MenuButtonNode(name: "playButton@1x")
        playButton.position = CGPoint(x: 813, y: -353.5)
        playButton.zPosition = 0
        addChild(playButton)
        buttons.append(playButton)
        
        configButton = MenuButtonNode(name: "configButton@1x")
        configButton.position = CGPoint(x: -828, y: -420.5)
        configButton.zPosition = 0
        addChild(configButton)
        buttons.append(configButton)
        
        for button in buttons {
            button.isUserInteractionEnabled = true
        }
    }
    
    func setupBackground(numberOfPlayers: Int, colorName: String) {
        let background = SKSpriteNode(imageNamed: "mainBackground@1x")
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = -1
        addChild(background)
        let firstShack = "FirstRoom@1x"
        let firstShackName = colorName + firstShack
        let secoundShack = "SecoundRoom@1x"
        let secoundShackName = colorName + secoundShack
        let thirdShack = "ThirdRoom@1x"
        let thirdShackName = colorName + thirdShack
        let forthShack = "ForthRoom@1x"
        let forthShackName = colorName + forthShack
        
        if numberOfPlayers == 2 {
            shack1 = MenuButtonNode(name: secoundShackName)
            shack1.position = CGPoint(x: -95, y: 90)
            shack1.zPosition = 0
            addChild(shack1)
            shacks.append(shack1)
            
            shack2 = MenuButtonNode(name: thirdShackName)
            shack2.position = CGPoint(x: 486, y: 98.5)
            shack2.zPosition = 0
            addChild(shack2)
            shacks.append(shack2)
        } else if numberOfPlayers == 3 {
            shack3 = MenuButtonNode(name: firstShackName)
            shack3.position = CGPoint(x: -529, y: -54)
            shack3.zPosition = 0
            addChild(shack3)
            shacks.append(shack3)
            
            shack4 = MenuButtonNode(name: secoundShackName)
            shack4.position = CGPoint(x: -95, y: 90)
            shack4.zPosition = 0
            addChild(shack4)
            shacks.append(shack4)
            
            shack5 = MenuButtonNode(name: thirdShackName)
            shack5.position = CGPoint(x: 486, y: 98.5)
            shack5.zPosition = 0
            addChild(shack5)
            shacks.append(shack5)
        } else if numberOfPlayers == 4 {
            shack3 = MenuButtonNode(name: firstShackName)
            shack3.position = CGPoint(x: -529, y: -54)
            shack3.zPosition = 0
            addChild(shack3)
            shacks.append(shack3)
            
            shack4 = MenuButtonNode(name: secoundShackName)
            shack4.position = CGPoint(x: -95, y: 90)
            shack4.zPosition = 0
            addChild(shack4)
            shacks.append(shack4)
            
            shack5 = MenuButtonNode(name: thirdShackName)
            shack5.position = CGPoint(x: 486, y: 98.5)
            shack5.zPosition = 0
            addChild(shack5)
            shacks.append(shack5)
        }
        
        for shack in shacks {
            shack.isUserInteractionEnabled = true
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
            if focussedItem == playButton {
                /* Load Game scene */
                guard let scene = GameChoices(fileNamed: "GameChoices") else {
                    print("Could not make GameChoices, check the name is spelled correctly")
                    return
                }
                loadScreens(scene: scene)
            } else {
                /* Load Configuration scene */
                guard let scene = GameConfiguration(fileNamed: "GameConfiguration") else {
                    print("Could not make GameConfiguration, check the name is spelled correctly")
                    return
                }
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
    
//    func loadGames() {
//        /* 1) Grab reference to our SpriteKit view */
//        guard let skView = self.view as SKView? else {
//            print("Could not get Skview")
//            return
//        }
//
//        /* 2) Load Game scene */
//        guard let scene = GameChoices(fileNamed: "GameChoices") else {
//            print("Could not make GameChoices, check the name is spelled correctly")
//            return
//        }
//
//        /* 3) Ensure correct aspect mode */
//        scene.scaleMode = .aspectFill
//
//        /* Show debug */
//        skView.showsPhysics = true
//        skView.showsDrawCount = true
//        skView.showsFPS = true
//
//        /* 4) Start game scene */
//        skView.presentScene(scene)
//    }
//
//    func loadConfiguration() {
//        /* 1) Grab reference to our SpriteKit view */
//        guard let skView = self.view as SKView? else {
//            print("Could not get Skview")
//            return
//        }
//
//        /* 2) Load Game scene */
//        guard let scene = GameConfiguration(fileNamed: "GameConfiguration") else {
//            print("Could not make GameConfiguration, check the name is spelled correctly")
//            return
//        }
//
//        /* 3) Ensure correct aspect mode */
//        scene.scaleMode = .aspectFill
//
//        /* Show debug */
//        skView.showsPhysics = true
//        skView.showsDrawCount = true
//        skView.showsFPS = true
//
//        /* 4) Start game scene */
//        skView.presentScene(scene)
//    }
}
