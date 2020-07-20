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
    var selectedTeam1: Bool?
    var participating: Bool?
    var messQuantity: Int?
    
//    convenience init(name: String) {
//        self.init()
//        let node = SKSpriteNode(imageNamed: name)
//        node.name = "teste"
//        addChild(node)
//    }
    init(name: String) {
        let texture = SKTexture(imageNamed: name)
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    init() {
        super.init(texture: nil, color:. clear, size: .zero)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
