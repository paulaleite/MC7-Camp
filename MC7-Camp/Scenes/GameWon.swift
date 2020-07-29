//
//  GameWon.swift
//  MC7-Camp
//
//  Created by Paula Leite on 15/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import SpriteKit
import CoreData

class GameWon: SKScene {
    var teamWon = Int()
    var playersThatWon = [Int]()
    var amountCleaned = Int()
    var game = String()
    
    var teamButtons = [MenuButtonNode]()
    var mainMenu = MenuButtonNode()
    var newGame = MenuButtonNode()
    var gameWonLabel = SKLabelNode()
    
    var context: NSManagedObjectContext?
    var coreDataManager: CoreDataManager?
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupText()
        setupUIButtons()
        fetchDataFromCoreData()
        addTapGestureRecognizer()
    }
    
    func fetchDataFromCoreData() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        coreDataManager = CoreDataManager(context: context!)
        
        guard let badgesWon = coreDataManager?.fetchBadgesWon(players: playersThatWon) else { return }
        
        positionBadges(badges: badgesWon)
    }
    
    func positionBadges(badges: [String]) {
        for i in 0 ..< badges.count {
            let badge = SKSpriteNode(imageNamed: badges[i])
            badge.size = CGSize(width: badge.size.width, height: badge.size.width)
            badge.position = CGPoint(x: 400 + (500 * i), y: 500)
            badge.zPosition = 1
            addChild(badge)
        }
    }
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "winningBoard")
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
    }
    
    func setupText() {
        gameWonLabel.fontColor = .black
        gameWonLabel.fontSize = 60
        gameWonLabel.numberOfLines = 0
        
        if game == "Collaborative" {
            gameWonLabel.text = NSLocalizedString("Won_Colaborative", comment: "Colaborative Game won.")
        } else {
            let localizedString = NSLocalizedString("Won_Competitive", comment: "Competetive Game won.")
            let teamWonText = String(teamWon)
            gameWonLabel.text = String(format: localizedString, teamWonText)
        }
        
        gameWonLabel.position = CGPoint(x: 960, y: 840)
        gameWonLabel.zPosition = 1
        addChild(gameWonLabel)
    }
    
    func setupConfirmButtonText() {
        let confirmButtonLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
        confirmButtonLabel.fontColor = .black
        confirmButtonLabel.fontSize = 55
        confirmButtonLabel.text = NSLocalizedString("Confirm_Button", comment: "Confirm button text.")
        confirmButtonLabel.position =  CGPoint(x: 1775, y: 120)
        confirmButtonLabel.zPosition = 1
        addChild(confirmButtonLabel)
    }
    
    func setupUIButtons() {
        setupConfirmButtonText()
        
        mainMenu = MenuButtonNode(name: "confirmButton2")
        mainMenu.size = CGSize(width: mainMenu.size.width/2.2, height: mainMenu.size.height/2.2)
        mainMenu.position = CGPoint(x: 1780, y: 120)
        mainMenu.zPosition = 0
        addChild(mainMenu)
        
        mainMenu.isUserInteractionEnabled = true
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
            if focussedItem == mainMenu {
                /* Load Main Menu scene */
                guard let size = view?.frame.size else { return }
                let scene = MainMenu(size: size)
                loadScreens(scene: scene)
            } else if focussedItem == newGame {
                /* Load GameChoices scene */
                guard let size = view?.frame.size else { return }
                let scene = GameChoices(size: size)
                loadScreens(scene: scene)
            }
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
