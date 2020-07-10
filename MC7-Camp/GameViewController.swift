//
//  GameViewController.swift
//  MC7-Camp
//
//  Created by Paula Leite on 08/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class GameViewController: UIViewController {
    
    var currentScene: SKScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {

            let scene = MainMenu(size: view.frame.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFit
            currentScene = scene
            // Present the scene

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true

            view.presentScene(scene)
        }
        
        
//        if let scene = MainMenu(fileNamed: "MainMenu") {
//            // Configure the view.
//            let skView = self.view as! SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
//
//            /* Sprite Kit applies additional optimizations to improve rendering performance */
//            skView.ignoresSiblingOrder = true
//
//            /* Set the scale mode to scale to fit the window */
//            scene.scaleMode = .aspectFit
//
//            skView.presentScene(scene)
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
