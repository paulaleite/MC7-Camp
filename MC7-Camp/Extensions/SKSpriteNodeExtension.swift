//
//  SKSpriteNodeExtension.swift
//  MC7-Camp
//
//  Created by Paula Leite on 09/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import SpriteKit

extension SKNode {

    func addGlow(radius: Float = 100) -> SKEffectNode {
        let view = SKView()
        let effectNode = SKEffectNode()
        let texture = view.texture(from: self)
        effectNode.shouldRasterize = true
        effectNode.blendMode = .add
        effectNode.filter = CIFilter(name: "CIGaussianBlur",parameters: ["inputRadius":radius])
        addChild(effectNode)
        effectNode.addChild(SKSpriteNode(texture: texture))
        return effectNode
    }
    
    func removeGlow(node: SKEffectNode) {
        removeChildren(in: [node])
    }
}
