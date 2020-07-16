//
//  MainMenu.swift
//  MC7-Camp
//
//  Created by Paula Leite on 08/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import UIKit
import SpriteKit
import CoreData

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
    
    var familyMembers: [FamilyMember] = []
    var familyMember: FamilyMember?
    var families: [Family] = []
    var family: Family?
    var rewards: [Reward] = []
    var reward: Reward?
    
    var context: NSManagedObjectContext?
    
    
    let backgroundImages = [
        SKSpriteNode(imageNamed: "mainBackground@1x"),
        SKSpriteNode(imageNamed: "mainBackground1@1x"),
        SKSpriteNode(imageNamed: "mainBackground2@1x")
    ]
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        callOnboarding()
        /* Set UI connections */
        setupButtons()
        numberOfPlayers = 3
        colorName = "white"
        
        setupBackground()
        
        setupShacks(numberOfPlayers: numberOfPlayers, colorName: colorName)
        
        addTapGestureRecognizer()
        
    }
    
    func callOnboarding() {
        do{
            guard let context = context else {
                return
            }
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            families = try context.fetch(Family.fetchRequest())
            rewards = try context.fetch(Reward.fetchRequest())
            
            if familyMembers.count == 0 {
                guard let size = view?.frame.size else { return }
                let scene = Onboarding(size: size)
                loadScreens(scene: scene)
            }
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
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
                loadScreens(scene: scene)
            } else if focussedItem == configButton {
                /* Load Configuration scene */
                guard let size = view?.frame.size else { return }
                let scene = GameConfiguration(size: size)
                loadScreens(scene: scene)
            } else {
                /* Load Personal View scene */
                guard let size = view?.frame.size else { return }
                let scene = PersonalView(size: size)
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
