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
        
//        buttonPlay.selectedHandler = {
//            self.loadGame()
//        }

    }
    
//    func loadGame() {
//        /* 1) Grab reference to our SpriteKit view */
//        guard let skView = self.view as SKView? else {
//            print("Could not get Skview")
//            return
//        }
//
//        /* 2) Load Game scene */
//        guard let scene = GameChoices(fileNamed: "GameChoices") else {
//            print("Could not make GameScene, check the name is spelled correctly")
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
