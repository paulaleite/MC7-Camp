//
//  GameChoices.swift
//  MC7-Camp
//
//  Created by Paula Leite on 08/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import SpriteKit

class GameChoices: SKScene {
    override func didMove(to view: SKView) {
        print("Inside Game Choices.")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch == touches.first {
                print("Going to Main Menu.")
            }
        }
    }
}
