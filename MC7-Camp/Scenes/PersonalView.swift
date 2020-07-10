//
//  PersonalView.swift
//  MC7-Camp
//
//  Created by Paula Leite on 09/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import SpriteKit

class PersonalView: SKScene {
    override func didMove(to view: SKView) {
        print("Inside Personal View.")
        setupBackground()
    }
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "individualViewBackground")
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
