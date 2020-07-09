//
//  GameConfiguration.swift
//  MC7-Camp
//
//  Created by Paula Leite on 09/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import SpriteKit

class GameConfiguration: SKScene {
    override func didMove(to view: SKView) {
        print("Inside Game Configuration.")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch == touches.first {
                print("Going to Main Menu.")
            }
        }
    }
}
