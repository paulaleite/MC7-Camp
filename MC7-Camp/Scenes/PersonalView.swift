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
    
    var context: NSManagedObjectContext?
    var coreDataManager: CoreDataManager?
    
    var mainScreenButton = MenuButtonNode()
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupUIButtons()
        showRewardsCoreData()
        addTapGestureRecognizer()
    }
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "individualViewBackground")
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
    }
    
    func setupUIButtons() {
        mainScreenButton = MenuButtonNode(name: "backButton")
        mainScreenButton.position = CGPoint(x: 120, y: 120)
        mainScreenButton.zPosition = 0
        addChild(mainScreenButton)
        mainScreenButton.isUserInteractionEnabled = true
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
            let badge = SKSpriteNode(imageNamed: badges[i])
            badge.position = CGPoint(x: 400 + (500 * i), y: 400 + (200  * i))
            badge.zPosition = 1
            addChild(badge)
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
