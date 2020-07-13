//
//  PageButton.swift
//  MC7-Camp
//
//  Created by Paula Leite on 08/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import SpriteKit

class MenuButtonNode: SKSpriteNode {
    
    var effectNode: SKEffectNode?
//    var node = SKSpriteNode()
    
    convenience init(name: String) {
        self.init()
        let node = SKSpriteNode(imageNamed: name)
//        node.texture = SKTexture(imageNamed: name)
        addChild(node)
    }
    
    override var canBecomeFocused: Bool {
        get {
            return true
        }
    }
    
    /* Setup a dummy action closure */
    var selectedHandler: () -> Void = { print("No button action set") }
    
    func buttonDidGetFocus() {
        effectNode = self.addGlow()
    }
    
    func buttonDidLoseFocus() {
        guard let effect = effectNode else { return }
        self.removeGlow(node: effect)
    }
    
}
