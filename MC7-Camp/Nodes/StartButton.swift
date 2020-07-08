//
//  StartButton.swift
//  MC7-Camp
//
//  Created by Paula Leite on 08/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//
import SpriteKit

enum StartButtonNodeState {
    case StartButtonNodeStateActive, StartButtonNodeStateSelected, StartButtonNodeStateHidden
}

class StartButtonNode: SKSpriteNode {
    
    override var canBecomeFocused: Bool {
        get {
            return true
        }
    }
    
    /* Setup a dummy action closure */
    var selectedHandler: () -> Void = { print("No button action set") }
    
    /* Button state management */
    var state: StartButtonNodeState = .StartButtonNodeStateActive {
        didSet {
            switch state {
            case .StartButtonNodeStateActive:
                /* Enable touch */
                self.isUserInteractionEnabled = true
                
                /* Visible */
                self.alpha = 1
                break
            case .StartButtonNodeStateSelected:
                /* Semi transparent */
                self.alpha = 0.7
                break
            case .StartButtonNodeStateHidden:
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
    
    // MARK: - Touch handling
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
////        selectedHandler()
//        print("tocado")
//        state = .StartButtonNodeStateSelected
//    }
//
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
////        selectedHandler()
//        state = .StartButtonNodeStateActive
//    }
    
    func buttonDidGetFocus() {
        print("ganhou focus")
    }
    
    func buttonDidLoseFocus() {
        print("perdeu focus")
    }
    
}
