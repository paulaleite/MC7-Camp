//
//  MainMenu.swift
//  MC7-Camp
//
//  Created by Paula Leite on 08/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import UIKit
import SpriteKit

class MainMenu: SKScene {
    
    /* UI Connections */
    var buttons = [MenuButtonNode]()
    var shacks = [MenuButtonNode]()
    var numberOfPlayers = Int()
    var colorName = String()
    var playButton = MenuButtonNode()
    var configButton = MenuButtonNode()
    var shack1 = MenuButtonNode()
    var shack2 = MenuButtonNode()
    var shack3 = MenuButtonNode()
    var background = SKSpriteNode()
    
    let backgroundImages = [
        SKSpriteNode(imageNamed: "mainBackground@1x"),
        SKSpriteNode(imageNamed: "mainBackground2@1x"),
        SKSpriteNode(imageNamed: "mainBackground3@1x")
    ]
    private var backgroundTimer:Timer?
    var isBackgroundTimerActive: Bool = Bool()
    var playedAGame: Bool = true
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        observeBackgroundChangeTimer()
        setupButtons()
        numberOfPlayers = 3
        colorName = "white"
        
        setupBackground()
        
        setupShacks(numberOfPlayers: numberOfPlayers, colorName: colorName)
        addTapGestureRecognizer()
        
    }
    func observeBackgroundChangeTimer(){
        if playedAGame{
            NotificationCenter.default.addObserver(self, selector: #selector(scheduleBackgroundChange), name:  UIApplication.didBecomeActiveNotification, object: nil)
        }
    }
    
    @objc func scheduleBackgroundChange() {
        let date = Date.init(timeIntervalSinceNow: 5)
        backgroundTimer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(changeBackground), userInfo: nil, repeats: false)
        guard let backgroundTimer = backgroundTimer else {
            return
        }
        isBackgroundTimerActive = true
        print(backgroundTimer.fireDate)
        RunLoop.main.add(backgroundTimer, forMode: RunLoop.Mode.common)
        print("new background change scheduled at:", backgroundTimer.fireDate.description(with: .current))
    }
    @objc func changeBackground(){
        if background.texture?.description == backgroundImages[0].texture?.description {
            print("true")
            background.texture = backgroundImages[1].texture
            observeBackgroundChangeTimer()
        } else if background.texture?.description == backgroundImages[1].texture?.description {
            background.texture = backgroundImages[2].texture
            isBackgroundTimerActive = false
        }
    }
//problema: quando o usuário entrar, como vai se comportar o timer? ele vai saber? Testar isso. Caso não role, fazer conta com data que eu coloco no userDefaults qunado acaba um jogo?
    
    func setupBackground() {
        background = SKSpriteNode(imageNamed: "mainBackground@1x")
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
    }
    
    func setupButtons() {
        playButton = MenuButtonNode(name: "playButton@1x")
        playButton.position = CGPoint(x: 1773, y: 186.5)
        playButton.zPosition = 0
        addChild(playButton)
        buttons.append(playButton)
        
        configButton = MenuButtonNode(name: "configButton@1x")
        configButton.position = CGPoint(x: 132, y: 119.5)
        configButton.zPosition = 0
        addChild(configButton)
        buttons.append(configButton)
        
        for button in buttons {
            button.isUserInteractionEnabled = true
        }
    }
    
    func setupShacks(numberOfPlayers: Int, colorName: String) {
        let firstShack = "FirstRoom@1x"
        let firstShackName = colorName + firstShack
        let secoundShack = "SecoundRoom@1x"
        let secoundShackName = colorName + secoundShack
        let thirdShack = "ThirdRoom@1x"
        let thirdShackName = colorName + thirdShack
        let forthShack = "ForthRoom@1x"
        let forthShackName = colorName + forthShack
        
        if numberOfPlayers == 2 {
            shack2 = MenuButtonNode(name: secoundShackName)
            shack2.position = CGPoint(x: 865, y: 630)
            shack2.zPosition = 0
            addChild(shack2)
            shacks.append(shack2)
            
            shack3 = MenuButtonNode(name: thirdShackName)
            shack3.position = CGPoint(x: 1446, y: 638.5)
            shack3.zPosition = 0
            addChild(shack3)
            shacks.append(shack3)
        } else if numberOfPlayers == 3 {
            shack1 = MenuButtonNode(name: firstShackName)
            shack1.position = CGPoint(x: 431, y: 486)
            shack1.zPosition = 0
            addChild(shack1)
            shacks.append(shack1)
            
            shack2 = MenuButtonNode(name: secoundShackName)
            shack2.position = CGPoint(x: 865, y: 630)
            shack2.zPosition = 0
            addChild(shack2)
            shacks.append(shack2)
            
            shack3 = MenuButtonNode(name: thirdShackName)
            shack3.position = CGPoint(x: 1446, y: 638.5)
            shack3.zPosition = 0
            addChild(shack3)
            shacks.append(shack3)
        } else if numberOfPlayers == 4 {
            shack1 = MenuButtonNode(name: firstShackName)
            shack1.position = CGPoint(x: 431, y: 486)
            shack1.zPosition = 0
            addChild(shack1)
            shacks.append(shack1)
            
            shack2 = MenuButtonNode(name: secoundShackName)
            shack2.position = CGPoint(x: 865, y: 630)
            shack2.zPosition = 0
            addChild(shack2)
            shacks.append(shack2)
            
            shack3 = MenuButtonNode(name: thirdShackName)
            shack3.position = CGPoint(x: 1446, y: 638.5)
            shack3.zPosition = 0
            addChild(shack3)
            shacks.append(shack3)
        }
        
        for shack in shacks {
            shack.isUserInteractionEnabled = true
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        let prevItem = context.previouslyFocusedItem
        let nextItem = context.nextFocusedItem
        
        if let prevButton = prevItem as? MenuButtonNode {
            prevButton.buttonDidLoseFocus()
        }
        
        if let nextButton = nextItem as? MenuButtonNode {
            nextButton.buttonDidGetFocus()
        }
    }
    
    func addTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        self.view?.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func tapped(sender: AnyObject) {
        if let focussedItem = UIScreen.main.focusedItem as? MenuButtonNode {
            if focussedItem == playButton {
                /* Load Game scene */
                guard let size = view?.frame.size else { return }
                let scene = GameChoices(size: size)
                print("Could not make GameChoices, check the name is spelled correctly")
                loadScreens(scene: scene)
            } else if focussedItem == configButton {
                /* Load Configuration scene */
                guard let size = view?.frame.size else { return }
                let scene = GameConfiguration(size: size)
                print("Could not make GameConfiguration, check the name is spelled correctly")
                loadScreens(scene: scene)
            } else {
                /* Load Personal View scene */
                guard let size = view?.frame.size else { return }
                let scene = PersonalView(size: size)
                print("Could not make PersonalView, check the name is spelled correctly")
                loadScreens(scene: scene)
            }
        }
        print("tapped")
    }
    
    func loadScreens(scene: SKScene) {
        /* Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }
        
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFill
        
        /* Show debug */
        skView.showsPhysics = true
        skView.showsDrawCount = true
        skView.showsFPS = true
        
        /* 4) Start game scene */
        skView.presentScene(scene)
    }

}
