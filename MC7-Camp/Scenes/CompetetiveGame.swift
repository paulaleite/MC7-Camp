//
//  BallGame.swift
//  MC7-Camp
//
//  Created by Paula Leite on 10/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import SpriteKit

class CompetetiveGame: SKScene {
    override func didMove(to view: SKView) {
        print("Inside Ball Game.")
        setupBackground()
    }
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "mainMenu")
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch == touches.first {
                print("Going to Main Menu.")
            }
        }
    }
}
