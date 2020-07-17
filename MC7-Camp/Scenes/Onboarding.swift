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

class Onboarding: SKScene{
    
    var familyMembers: [FamilyMember] = []
    var familyMember: FamilyMember?
    var families: [Family] = []
    var family: Family?
    var background = SKSpriteNode()
    var askAmountOfMembersLabel = SKLabelNode()
    var amountOfMembersLabel = SKLabelNode()
    var increaseAmountOfMembersButton = MenuButtonNode()
    var decreaseAmountOfMembersButton = MenuButtonNode()
    var doneSettingUpButton = MenuButtonNode()
    var buttons = [MenuButtonNode]()
    var numberOfFamilyMembers: Int64 = 0
    var context: NSManagedObjectContext?
    
    var didGoToOnboarding = Bool()
    
    override func didMove(to view: SKView) {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
        setupBackground()
        setupUI()
        addTapGestureRecognizer()
    }
    
    func setupBackground() {
        background = SKSpriteNode(imageNamed: "mainBackground@1x")
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
    }
    
    func setupUI() {
        askAmountOfMembersLabel.fontColor = .black
        askAmountOfMembersLabel.fontSize = 60
        askAmountOfMembersLabel.text = "Quantos membros tem sua família?"
        askAmountOfMembersLabel.position = CGPoint(x:960, y:860)
        askAmountOfMembersLabel.zPosition = 0
        addChild(askAmountOfMembersLabel)
        
        amountOfMembersLabel.fontColor = .black
        amountOfMembersLabel.fontSize = 120
        amountOfMembersLabel.text = String(numberOfFamilyMembers)
        amountOfMembersLabel.position = CGPoint(x: 960, y:540)
        amountOfMembersLabel.zPosition = 0
        addChild(amountOfMembersLabel)
        
        increaseAmountOfMembersButton = MenuButtonNode(name: "increaseButtonImage")
        increaseAmountOfMembersButton.position = CGPoint(x: 1402.5, y: 540)
        increaseAmountOfMembersButton.zPosition = 0
        addChild(increaseAmountOfMembersButton)
        buttons.append(increaseAmountOfMembersButton)
        
        decreaseAmountOfMembersButton = MenuButtonNode(name: "decreaseButtonImage")
        decreaseAmountOfMembersButton.position = CGPoint(x: 517.5, y:540)
        addChild(decreaseAmountOfMembersButton)
        buttons.append(decreaseAmountOfMembersButton)
        
        doneSettingUpButton = MenuButtonNode(name: "playButton@1x")
        doneSettingUpButton.position = CGPoint (x: 960, y: 216)
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
                if numberOfFamilyMembers > 0 {
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
        print("tapped")
    }
    
    func saveData() {
        do {
            guard let context = context else { return }
            families = try context.fetch(Family.fetchRequest())
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            
            if self.numberOfFamilyMembers != 0 {
                guard let family = NSEntityDescription.insertNewObject(forEntityName: "Family", into: context) as? Family else { return }
                
                
                family.numberOfFamilyMembers = self.numberOfFamilyMembers
                family.familyName = nil
                
                var i = 0
                let nameFlag = "shack"
                while i < family.numberOfFamilyMembers {
                    guard let familyMember = NSEntityDescription.insertNewObject(forEntityName: "FamilyMember", into: context) as? FamilyMember else { return }
                    
                    let colorFlag = nameFlag + "\(i + 1)"
                    familyMember.flagName = colorFlag
                    family.familyMember = familyMember
                    
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
