//
//  PersonalView.swift
//  MC7-Camp
//
//  Created by Paula Leite on 09/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import SpriteKit
import CoreData

class PersonalView: SKScene {
    var playerSelected = Int()
    var shackNames = [String]()
    
    var context: NSManagedObjectContext?
    var coreDataManager: CoreDataManager?
    
    var mainScreenButton = MenuButtonNode()
    var badges2 = [MenuButtonNode]()
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupUIButtons()
        showRewardsCoreData()
        addTapGestureRecognizer()
    }
    
    func setupBackground() {
        //        let nameOfBackground = "individualViewBackground" + "\(shackNames[self.playerSelected])"
        let nameOfBackground = "individualViewBackground" + "\(playerSelected + 1)"
        
        let background = SKSpriteNode(imageNamed: nameOfBackground)
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
    }
    
    func setupUIButtons() {
        mainScreenButton = MenuButtonNode(name: "backButton")
        mainScreenButton.size = CGSize(width: mainScreenButton.size.width/8, height: mainScreenButton.size.height/8)
        mainScreenButton.position = CGPoint(x: 120, y: 120)
        mainScreenButton.zPosition = 0
        addChild(mainScreenButton)
        mainScreenButton.isUserInteractionEnabled = true
    }
    
    func shackNamesCoreData() {
        let application = UIApplication.shared.delegate as! AppDelegate
        
        context = application.persistentContainer.viewContext
        coreDataManager = CoreDataManager(context: context!)
        
        guard let shacks = coreDataManager?.fetchShacksFromCoreData() else { return }
        
        self.shackNames = shacks
    }
    
    func showRewardsCoreData() {
        let application = UIApplication.shared.delegate as! AppDelegate
        
        context = application.persistentContainer.viewContext
        coreDataManager = CoreDataManager(context: context!)
        
        guard let badges = coreDataManager?.fetchPlayerBadges(player: playerSelected) else { return }
        
        // Posicionar todas badges
        positionBadges(badges: badges)
        
    }
    
    func positionBadges(badges: [String]) {
        
        for i in 0 ..< badges.count {
            if badges[i] == "rewardMess1.0" {
                let badge = MenuButtonNode(name: "rewardMess1.0")
                badge.size = CGSize(width: badge.size.width/3, height: badge.size.height/3)
                badge.position = CGPoint(x: 737, y: 120)
                badge.zPosition = 1
                addChild(badge)
                badges2.append(badge)
            } else if badges[i] == "rewardBasketball1.0" {
                let badge = MenuButtonNode(name: "rewardBasketball1.0")
                badge.size = CGSize(width: badge.size.width/3, height: badge.size.height/3)
                badge.position = CGPoint(x: 230, y: 283)
                badge.zPosition = 1
                addChild(badge)
                badges2.append(badge)
            } else if badges[i] == "rewardMess10.0" {
                let badge = MenuButtonNode(name: "rewardMess10.0")
                badge.size = CGSize(width: badge.size.width/3, height: badge.size.height/3)
                badge.position = CGPoint(x: 680, y: 315)
                badge.zPosition = 1
                addChild(badge)
                badges2.append(badge)
            } else if badges[i] == "rewardBasketball5.0"{
                let badge = MenuButtonNode(name: "rewardBasketball5.0")
                badge.size = CGSize(width: badge.size.width/3, height: badge.size.height/3)
                badge.position = CGPoint(x: 900, y: 540)
                badge.zPosition = 1
                addChild(badge)
                badges2.append(badge)
            } else if badges[i] == "rewardBasketball10.0"{
                let badge = MenuButtonNode(name: "rewardBasketball10.0")
                badge.size = CGSize(width: badge.size.width/3, height: badge.size.height/3)
                badge.position = CGPoint(x: 108, y: 380)
                badge.zPosition = 1
                addChild(badge)
                badges2.append(badge)
            } else if badges[i] == "rewardMess5.0"{
                let badge = MenuButtonNode(name: "rewardMess5.0")
                badge.size = CGSize(width: badge.size.width/3, height: badge.size.height/3)
                badge.position = CGPoint(x: 120, y: 180)
                badge.zPosition = 1
                addChild(badge)
                badges2.append(badge)
            }            
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
            if focussedItem == mainScreenButton {
                /* Load Game Choices scene */
                guard let size = view?.frame.size else { return }
                let scene = MainMenu(size: size)
                loadScreen(scene: scene)
            }
        }
    }
    
    func loadScreen(scene: SKScene) {
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
