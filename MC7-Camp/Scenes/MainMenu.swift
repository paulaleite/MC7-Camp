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
var buttonPlay: StartButtonNode!

    override func didMove(to view: SKView) {
        /* Setup your scene here */

        /* Set UI connections */
        buttonPlay = self.childNode(withName: "buttonPlay") as? StartButtonNode
        buttonPlay.isUserInteractionEnabled = true
        
//        buttonPlay.selectedHandler = {
//            self.loadGame()
//        }
        
         addTapGestureRecognizer()

    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        let prevItem = context.previouslyFocusedItem
        let nextItem = context.nextFocusedItem
        
        if let prevButton = prevItem as? StartButtonNode {
          prevButton.buttonDidLoseFocus()
        }
        if let nextButton = nextItem as? StartButtonNode {
          nextButton.buttonDidGetFocus()
        }
    }
    
    func addTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        self.view?.addGestureRecognizer(tapRecognizer)
    }

    @objc func tapped(sender:AnyObject) {
//        if let focussedItem = UIScreen.main.focusedItem as? StartButtonNode {
//            focussedItem.positionedMenuButton?.tapped()
//        }
        print("tapped")
        self.loadGame()
    }
    
    func loadGame() {
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
}
