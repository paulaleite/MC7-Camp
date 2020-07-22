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
    var configButton = MenuButtonNode()
    var shack1 = MenuButtonNode()
    var shack2 = MenuButtonNode()
    var shack3 = MenuButtonNode()
    var background = SKSpriteNode()

    var nameOfShacks = [String]()
    
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
             background = SKSpriteNode(imageNamed: "mainBackground@1x")
        } else if timeSincePLayed <= 518400 {
             background = SKSpriteNode(imageNamed: "mainBackground2@1x")
        } else {
            background = SKSpriteNode(imageNamed: "mainBackground3@1x")
        }
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
    
    func setupShacks() {
        fetchDataFromCoreData()
        
        for i in 0 ..< Int(numberOfPlayers) {
            let shack = MenuButtonNode(name: nameOfShacks[i])
            shack.position = CGPoint(x: 400 + (500 * i), y: 400 + (200  * i))
            shack.zPosition = 1
            addChild(shack)
            shacks.append(shack)
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
                //test button condition - remove it!
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
