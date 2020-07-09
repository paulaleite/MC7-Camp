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
    
    override var canBecomeFocused: Bool {
        get {
            return true
        }
    }
    
    /* Setup a dummy action closure */
    var selectedHandler: () -> Void = { print("No button action set") }
    
    /* Support for NSKeyedArchiver (loading objects from SK Scene Editor */
    required init?(coder aDecoder: NSCoder) {
        
        /* Call parent initializer e.g. SKSpriteNode */
        super.init(coder: aDecoder)
        
        /* Enable touch on button node */
        self.isUserInteractionEnabled = true
    }
    
    func buttonDidGetFocus() {
        effectNode = self.addGlow()
    }
    
    func buttonDidLoseFocus() {
        guard let effect = effectNode else { return }
        self.removeGlow(node: effect)
    }
    
}
