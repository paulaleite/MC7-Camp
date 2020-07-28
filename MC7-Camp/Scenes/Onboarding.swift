//
//  Onboarding.swift
//  MC7-Camp
//
//  Created by Amaury A V A Souza on 16/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import SpriteKit
import CoreData
import TVServices

class Onboarding: SKScene {
    
    var familyMembers: [FamilyMember] = []
    var familyMember: FamilyMember?
    var families: [Family] = []
    var family: Family?
    var background = SKSpriteNode()
    var increaseAmountOfMembersButton = MenuButtonNode()
    var decreaseAmountOfMembersButton = MenuButtonNode()
    var doneSettingUpButton = MenuButtonNode()
    var buttons = [MenuButtonNode]()
    var numberOfFamilyMembers: Int64 = 2
    var context: NSManagedObjectContext?
    
    var askAmountOfMembersLabel = SKLabelNode()
    var amountOfMembersLabel = SKLabelNode()
    var increaseAmountOfMembersLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
    var decreaseAmountOfMembersLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
    var doneSettingUpLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
    
    var didGoToOnboarding = Bool()
    
    override func didMove(to view: SKView) {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
        setupBackground()
        setupUI()
        addTapGestureRecognizer()
    }
    
    func setupBackground() {
        background = SKSpriteNode(imageNamed: "mainMenuBackground")
        background.size = self.size
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
    }
    
    func setupUI() {
        askAmountOfMembersLabel.fontName = "Pompiere-Regular"
        askAmountOfMembersLabel.fontColor = .black
        askAmountOfMembersLabel.fontSize = 70
        askAmountOfMembersLabel.text = NSLocalizedString("Ask_Amount_Members", comment: "Asks abuout the amount of members in the family.")
        askAmountOfMembersLabel.position = CGPoint(x: 960, y: 940)
        askAmountOfMembersLabel.zPosition = 0
        addChild(askAmountOfMembersLabel)
        
        amountOfMembersLabel.fontName = "Pompiere-Regular"
        amountOfMembersLabel.fontColor = .black
        amountOfMembersLabel.fontSize = 120
        amountOfMembersLabel.text = String(numberOfFamilyMembers)
        amountOfMembersLabel.position = CGPoint(x: 960, y: 440)
        amountOfMembersLabel.zPosition = 0
        addChild(amountOfMembersLabel)
        
        increaseAmountOfMembersLabel.fontColor = .black
        increaseAmountOfMembersLabel.numberOfLines = 0
        increaseAmountOfMembersLabel.fontSize = 70
        increaseAmountOfMembersLabel.text = NSLocalizedString("Increase_Amount", comment: "Button to increase amount of players.")
        increaseAmountOfMembersLabel.position = CGPoint(x: 1420, y: 400)
        increaseAmountOfMembersLabel.zPosition = 1
        addChild(increaseAmountOfMembersLabel)
        
        increaseAmountOfMembersButton = MenuButtonNode(name: "decreaseButtonImage")
        increaseAmountOfMembersButton.position = CGPoint(x: 1402.5, y: 440)
        increaseAmountOfMembersButton.zPosition = 0
        addChild(increaseAmountOfMembersButton)
        buttons.append(increaseAmountOfMembersButton)
        
        decreaseAmountOfMembersLabel.fontColor = .black
        decreaseAmountOfMembersLabel.numberOfLines = 0
        decreaseAmountOfMembersLabel.fontSize = 70
        decreaseAmountOfMembersLabel.text = NSLocalizedString("Decrease_Amount", comment: "Button to increase amount of players.")
        decreaseAmountOfMembersLabel.position = CGPoint(x: 517.5, y: 400)
        decreaseAmountOfMembersLabel.zPosition = 1
        addChild(decreaseAmountOfMembersLabel)
        
        decreaseAmountOfMembersButton = MenuButtonNode(name: "increaseButtonImage")
        decreaseAmountOfMembersButton.position = CGPoint(x: 517.5, y: 440)
        addChild(decreaseAmountOfMembersButton)
        buttons.append(decreaseAmountOfMembersButton)
        
        doneSettingUpLabel.fontColor = .black
        doneSettingUpLabel.numberOfLines = 0
        doneSettingUpLabel.fontSize = 60
        doneSettingUpLabel.text = NSLocalizedString("Play_Button", comment: "Play button text.")
        doneSettingUpLabel.position = CGPoint(x: 1795, y: 105)
        doneSettingUpLabel.zPosition = 1
        addChild(doneSettingUpLabel)
        
        doneSettingUpButton = MenuButtonNode(name: "playButton")
        doneSettingUpButton.position = CGPoint(x: 1800, y: 120)
        addChild(doneSettingUpButton)
        buttons.append(doneSettingUpButton)
        
        for button in buttons {
            button.isUserInteractionEnabled = true
        }
    }
    
    func updateNumberOfMembersLabel() {
        amountOfMembersLabel.text = String(numberOfFamilyMembers)
    }
    
    func addTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        self.view?.addGestureRecognizer(tapRecognizer)
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
    
    @objc func tapped(sender: AnyObject) {
        if let focussedItem = UIScreen.main.focusedItem as? MenuButtonNode {
            if focussedItem == decreaseAmountOfMembersButton {
                if numberOfFamilyMembers > 2 {
                    numberOfFamilyMembers -= 1
                    updateNumberOfMembersLabel()
                }
            } else if focussedItem == increaseAmountOfMembersButton {
                if numberOfFamilyMembers < 6 {
                    numberOfFamilyMembers += 1
                    updateNumberOfMembersLabel()
                }
            } else {
                saveData()
                guard let size = view?.frame.size else { return }
                let scene = MainMenu(size: size)
                loadScreens(scene: scene)
            }
        }
    }
    
    func saveData() {
        do {
            guard let context = context else { return }
            families = try context.fetch(Family.fetchRequest())
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            
            if self.numberOfFamilyMembers != 0 {
                guard let family = NSEntityDescription.insertNewObject(forEntityName: "Family", into: context) as? Family else { return }
                
                
                family.numberOfFamilyMembers = self.numberOfFamilyMembers
                
                var i = 0
                let nameShack = "shack"
                let nameFlag = "flag"
                while i < family.numberOfFamilyMembers {
                    guard let familyMember = NSEntityDescription.insertNewObject(forEntityName: "FamilyMember", into: context) as? FamilyMember else { return }
                    
                    let nameShack = nameShack + "\(i + 1)"
                    familyMember.shackName = nameShack
                    let nameFlag = nameFlag + "\(i + 1)"
                    familyMember.flagName = nameFlag
                    familyMember.timesPlayedBasketballGame = 0.0
                    familyMember.timesPlayedMessGame = 0.0
                    familyMember.family = family
                    
                    self.familyMembers.append(familyMember)
                    i = i + 1
                }
                
                self.families.append(family)
            }
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            didGoToOnboarding = true
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
   
    func loadScreens(scene: SKScene) {
        /* Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }
        skView.showsFPS = false
        skView.showsNodeCount = false
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFill
        

        /* 4) Start game scene */
        skView.presentScene(scene)
    }
}
