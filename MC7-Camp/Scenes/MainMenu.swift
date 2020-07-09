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
    var playButton: MenuButtonNode!
    var configButton: MenuButtonNode!
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        /* Set UI connections */
        playButton = self.childNode(withName: "buttonPlay") as? MenuButtonNode
        buttons.append(playButton)
        
        
        configButton = self.childNode(withName: "configButton") as? MenuButtonNode
        buttons.append(configButton)
        
        
        addTapGestureRecognizer()
        
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
            if focussedItem.name == "buttonPlay" {
                self.loadGames()
            } else {
                self.loadConfiguration()
            }
        }
        print("tapped")
    }
    
    func loadGames() {
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }
        
        /* 2) Load Game scene */
        guard let scene = GameChoices(fileNamed: "GameChoices") else {
            print("Could not make GameChoices, check the name is spelled correctly")
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
    
    func loadConfiguration() {
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }
        
        /* 2) Load Game scene */
        guard let scene = GameConfiguration(fileNamed: "GameConfiguration") else {
            print("Could not make GameConfiguration, check the name is spelled correctly")
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
