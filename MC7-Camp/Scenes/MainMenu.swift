//
//  MainMenu.swift
//  MC7-Camp
//
//  Created by Paula Leite on 08/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//
// TEST BACKGROUND BUTTON HAS TO GO AWAY, FUNCTION ATTACHED TO IT SHOULD BE CALLED WHEN YOU RUN A GAME - setting user defaults to be implemented in appropriate screens

import UIKit
import SpriteKit
import CoreData

class MainMenu: SKScene {
    
    /* UI Connections */
    var buttons = [MenuButtonNode]()
    var shacks = [MenuButtonNode]()
    var numberOfPlayers = Int64()
    var colorName = String()
    var playButton = MenuButtonNode()
    var background = SKSpriteNode()

    var nameOfShacks = [String]()
    var shack1 = MenuButtonNode()
    var shack2 = MenuButtonNode()
    var shack3 = MenuButtonNode()
    var shack4 = MenuButtonNode()
    var shack5 = MenuButtonNode()
    var shack6 = MenuButtonNode()
    
    var familyMembers: [FamilyMember] = []
    var familyMember: FamilyMember?
    var families: [Family] = []
    var family: Family?
    var rewards: [Reward] = []
    var reward: Reward?
    
    var context: NSManagedObjectContext?
    var coreDataManager: CoreDataManager?

    let backgroundImages = [
        SKSpriteNode(imageNamed: "mainBackground@1x"),
        SKSpriteNode(imageNamed: "mainBackground2@1x"),
        SKSpriteNode(imageNamed: "mainBackground3@1x")
    ]

    let defaults = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        callOnboarding()
        
        addTapGestureRecognizer()
    }
    
    override func sceneDidLoad() {
        /* Set UI connections */

        setupButtons()
        
        setupBackground()
        
        setupShacks()
    }
    
    func fetchDataFromCoreData() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        coreDataManager = CoreDataManager(context: context!)
        
        guard let nameShacks = coreDataManager?.fetchShacksFromCoreData() else { return  }
        self.nameOfShacks = nameShacks
        
        guard let numberPlayers = coreDataManager?.fetchNumberOfPlayersFromCoreData() else { return }
        
        self.numberOfPlayers = numberPlayers
    }
    
    func callOnboarding() {
        do {
            guard let context = context else { return }
            
            families = try context.fetch(Family.fetchRequest())
            
            if families.count == 0 {
                guard let size = view?.frame.size else { return }
                let scene = Onboarding(size: size)
                loadScreens(scene: scene)
            }
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        } catch let error{
            print(error.localizedDescription)
        }
    }
    
    func lastPlayedDate(){
        defaults.set(Date(timeIntervalSinceNow: 0), forKey: "LastPlayed")
    }
        
    func setupBackground() {
        let lastPlayedDate = defaults.object(forKey: "LastPlayed") as? Date
        let rightNow = Date(timeIntervalSinceNow: 0)
        let timeSincePLayed = rightNow.timeIntervalSince(lastPlayedDate ?? Date(timeIntervalSinceReferenceDate: 0))
        if timeSincePLayed <= 259200 {
             background = SKSpriteNode(imageNamed: "mainBackground")
        } else if timeSincePLayed <= 518400 {
             background = SKSpriteNode(imageNamed: "mainBackground2")
        } else {
            background = SKSpriteNode(imageNamed: "mainMenuBackground3")
        }
        background.size = self.size
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
    }
    
    func setupButtons() {
        playButton = MenuButtonNode(name: "playButton")
        playButton.position = CGPoint(x: 1800, y: 120)
        playButton.zPosition = 0
        addChild(playButton)
        buttons.append(playButton)
        
        for button in buttons {
            button.isUserInteractionEnabled = true
        }
    }
    
    func setupShacks() {
        fetchDataFromCoreData()
        
//        let radius: CGFloat = 500
//        let center = CGPoint(x: -960, y: -198)
//
//        for i in 0 ..< Int(numberOfPlayers) {
//            let shack = MenuButtonNode(name: nameOfShacks[i])
//
//            let coss = CGFloat(cos(Double(i * 45) * Double.pi / 180))
//            let sinn = CGFloat(sin(Double(i * 45) * Double.pi / 180))
//
//            shack.position.x = shack.position.x + (radius * coss) - center.x
//            shack.position.y = shack.position.y + (radius * sinn) - center.y
//
//            shack.zPosition = 1
//            addChild(shack)
//
//            shacks.append(shack)
//        }
        
        if numberOfPlayers == 2 {
            shack2 = MenuButtonNode(name: "shack2")
            shack2.position = CGPoint(x: 480, y: 490)
            shack2.zPosition = 0
            addChild(shack2)
            shacks.append(shack2)

            shack5 = MenuButtonNode(name: "shack5")
            shack5.position = CGPoint(x: 1500, y: 490)
            shack5.zPosition = 0
            addChild(shack5)
            shacks.append(shack5)
        } else if numberOfPlayers == 3 {
            shack1 = MenuButtonNode(name: "shack1")
            shack1.position = CGPoint(x: 185, y: 380)
            shack1.zPosition = 0
            addChild(shack1)
            shacks.append(shack1)

            shack3 = MenuButtonNode(name: "shack3")
            shack3.position = CGPoint(x: 775, y: 540)
            shack3.zPosition = 0
            addChild(shack3)
            shacks.append(shack3)

            shack6 = MenuButtonNode(name: "shack6")
            shack6.position = CGPoint(x: 1700, y: 380)
            shack6.zPosition = 0
            addChild(shack6)
            shacks.append(shack6)
        } else if numberOfPlayers == 4 {
            shack1 = MenuButtonNode(name: "shack1")
            shack1.position = CGPoint(x: 185, y: 380)
            shack1.zPosition = 0
            addChild(shack1)
            shacks.append(shack1)

            shack3 = MenuButtonNode(name: "shack3")
            shack3.position = CGPoint(x: 775, y: 540)
            shack3.zPosition = 0
            addChild(shack3)
            shacks.append(shack3)

            shack4 = MenuButtonNode(name: "shack4")
            shack4.position = CGPoint(x: 1200, y: 540)
            shack4.zPosition = 0
            addChild(shack4)
            shacks.append(shack4)

            shack6 = MenuButtonNode(name: "shack6")
            shack6.position = CGPoint(x: 1700, y: 380)
            shack6.zPosition = 0
            addChild(shack6)
            shacks.append(shack6)
        } else if numberOfPlayers == 5 {
            shack1 = MenuButtonNode(name: "shack1")
            shack1.position = CGPoint(x: 185, y: 380)
            shack1.zPosition = 0
            addChild(shack1)
            shacks.append(shack1)

            shack2 = MenuButtonNode(name: "shack2")
            shack2.position = CGPoint(x: 480, y: 490)
            shack2.zPosition = 0
            addChild(shack2)
            shacks.append(shack2)

            shack3 = MenuButtonNode(name: "shack3")
            shack3.position = CGPoint(x: 775, y: 540)
            shack3.zPosition = 0
            addChild(shack3)
            shacks.append(shack3)

            shack5 = MenuButtonNode(name: "shack5")
            shack5.position = CGPoint(x: 1500, y: 490)
            shack5.zPosition = 0
            addChild(shack5)
            shacks.append(shack5)

            shack6 = MenuButtonNode(name: "shack6")
            shack6.position = CGPoint(x: 1700, y: 380)
            shack6.zPosition = 0
            addChild(shack6)
            shacks.append(shack6)
        } else if numberOfPlayers == 6 {
            shack1 = MenuButtonNode(name: "shack1")
            shack1.position = CGPoint(x: 185, y: 380)
            shack1.zPosition = 0
            addChild(shack1)
            shacks.append(shack1)

            shack2 = MenuButtonNode(name: "shack2")
            shack2.position = CGPoint(x: 480, y: 490)
            shack2.zPosition = 0
            addChild(shack2)
            shacks.append(shack2)

            shack3 = MenuButtonNode(name: "shack3")
            shack3.position = CGPoint(x: 775, y: 540)
            shack3.zPosition = 0
            addChild(shack3)
            shacks.append(shack3)

            shack4 = MenuButtonNode(name: "shack4")
            shack4.position = CGPoint(x: 1200, y: 540)
            shack4.zPosition = 0
            addChild(shack4)
            shacks.append(shack4)

            shack5 = MenuButtonNode(name: "shack5")
            shack5.position = CGPoint(x: 1500, y: 490)
            shack5.zPosition = 0
            addChild(shack5)
            shacks.append(shack5)

            shack6 = MenuButtonNode(name: "shack6")
            shack6.position = CGPoint(x: 1700, y: 380)
            shack6.zPosition = 0
            addChild(shack6)
            shacks.append(shack6)

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
            } else {
                for i in 0 ..< shacks.count {
                    let button = shacks[i]
                    if button != focussedItem {
                        continue
                    }
                    guard let size = view?.frame.size else { return }
                    let scene = PersonalView(size: size)
                    scene.playerSelected = i
                    loadScreens(scene: scene)
                }
            }
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
