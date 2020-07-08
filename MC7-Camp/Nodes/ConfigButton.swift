//
//  ConfigButton.swift
//  MC7-Camp
//
//  Created by Paula Leite on 08/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import SpriteKit

enum ConfigButtonNodeState {
    case ConfigButtonNodeStateActive, ConfigButtonNodeStateSelected, ConfigButtonNodeStateHidden
}

class ConfigButtonNode: SKSpriteNode {
    
    override var canBecomeFocused: Bool {
        get {
            return true
        }
    }
    
    /* Setup a dummy action closure */
    var selectedHandler: () -> Void = { print("No button action set") }
    
    /* Button state management */
    var state: ConfigButtonNodeState = .ConfigButtonNodeStateActive {
        didSet {
            switch state {
            case .ConfigButtonNodeStateActive:
                /* Enable touch */
                self.isUserInteractionEnabled = true
                
                /* Visible */
                self.alpha = 1
                break
            case .ConfigButtonNodeStateSelected:
                /* Semi transparent */
                self.alpha = 0.7
                break
            case .ConfigButtonNodeStateHidden:
                /* Disable touch */
                self.isUserInteractionEnabled = false
                
                /* Hide */
                self.alpha = 0
                break
            }
        }
    }
    
    /* Support for NSKeyedArchiver (loading objects from SK Scene Editor */
    required init?(coder aDecoder: NSCoder) {
        
        /* Call parent initializer e.g. SKSpriteNode */
        super.init(coder: aDecoder)
        
        /* Enable touch on button node */
        self.isUserInteractionEnabled = true
    }
    
    func buttonDidGetFocus() {
        print("ganhou focus")
    }
    
    func buttonDidLoseFocus() {
        print("perdeu focus")
    }
    
}
