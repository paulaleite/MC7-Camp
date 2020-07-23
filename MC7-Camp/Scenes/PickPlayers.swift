//
//  PickPlayers.swift
//  MC7-Camp
//
//  Created by Paula Leite on 14/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import SpriteKit
import CoreData

class PickPlayers: SKScene {
    var backgroundImage = String()
    var nameGameChosen = String()
    var participating = [Int]()
    
    var backButton = MenuButtonNode()
    var buttons = [MenuButtonNode]()
    var teamButtons = [MenuButtonNode]()
    var playButton = MenuButtonNode()
    
    var colorName = [String]()
    var nameOfFlags = [String]()
    
    var flagButtons = [MenuButtonNode]()
    
    var numberOfPlayers = Int64()
    var context: NSManagedObjectContext?
    var coreDataManager: CoreDataManager?
    
    override func didMove(to view: SKView) {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        setupBackground()
        setupUIButtons()
        
        numberOfPlayers = 3
        setupTeamButtons()
        
        addTapGestureRecognizer()
    }
    
    func fetchDataFromCoreData() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        coreDataManager = CoreDataManager(context: context!)
        
        guard let nameFlags = coreDataManager?.fetchFlagsFromCoreData() else { return  }
        self.nameOfFlags = nameFlags
        
        guard let numberPlayers = coreDataManager?.fetchNumberOfPlayersFromCoreData() else { return }
        
        self.numberOfPlayers = numberPlayers
    }
    
    func setupUIButtons() {
        backButton = MenuButtonNode(name: "backButton")
        backButton.position = CGPoint(x: 120, y: 120)
        backButton.zPosition = 0
        addChild(backButton)
        buttons.append(backButton)
        
        playButton = MenuButtonNode(name: "playButton")
        playButton.position = CGPoint(x: 1800, y: 120)
        playButton.zPosition = 0
        addChild(playButton)
        buttons.append(playButton)
        
        for button in buttons {
            button.isUserInteractionEnabled = true
        }
    }
    
    func setupTeamButtons() {
        fetchDataFromCoreData()
        let spaceBetweenFlags = 800/Int(numberOfPlayers)
        for i in 0 ..< Int(numberOfPlayers) {
            let flagSelected = MenuButtonNode(name: nameOfFlags[i])
            flagSelected.position = CGPoint(x: 761, y: 800 - (spaceBetweenFlags  * i))
            flagSelected.zPosition = 1
            addChild(flagSelected)
            flagButtons.append(flagSelected)
            flagSelected.participating = false
            
            participating.append(0)
        }
        
        for flagButton in flagButtons {
            flagButton.isUserInteractionEnabled = true
        }
    }
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "chooseParticipants")
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
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
            
            if focussedItem == backButton {
                /* Load Game Choices scene */
                guard let size = view?.frame.size else { return }
                let scene = GameChoices(size: size)
                loadScreens(scene: scene)
            } else if focussedItem == playButton {
                if nameGameChosen == "Bagunca" {
                    /* Load Colaborative GAme scene */
                    guard let size = view?.frame.size else { return }
                    let scene = ColaborativeGame(size: size)
                    scene.participating = self.participating
                    // I need to send which players are playing.
                    loadScreens(scene: scene)
                } else if nameGameChosen == "Basquete" {
                    /* Load Colaborative GAme scene */
                    guard let size = view?.frame.size else { return }
                    let scene = PickTeam(size: size)
                    // I need to send which players are playing.
                    scene.participating = self.participating
                    loadScreens(scene: scene)
                }
            }
            
            for i in 0 ..< flagButtons.count {
                let button = flagButtons[i]
                if button != focussedItem {
                    continue
                }
                if button.participating == true {
                    button.position = CGPoint(x: 761, y: button.position.y)
                    button.participating = false
                    participating[i] = 0
                } else {
                    button.position = CGPoint(x: 1208, y: button.position.y)
                    button.participating = true
                    participating[i] = 1
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
        
        /* 4) Start game scene */
        skView.presentScene(scene)
    }
}
