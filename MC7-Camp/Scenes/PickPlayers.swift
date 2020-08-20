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
        setupTeamButtons()
        setupTexts()
        checkAmountOfPlayers()
        
        addTapGestureRecognizer()
        pressMenuRecognizer()
    }
    
    func checkAmountOfPlayers() {
        var peopleParticipating = [Int]()
        for i in 0 ..< participating.count {
            if participating[i] == 1 {
                peopleParticipating.append(1)
            }
        }
        
        if peopleParticipating.count > 0 {
            playButton.isUserInteractionEnabled = true
        } else {
            playButton.isUserInteractionEnabled = false
        }
    }
    
    func fetchDataFromCoreData() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        coreDataManager = CoreDataManager(context: context!)
        
        guard let nameFlags = coreDataManager?.fetchFlagsFromCoreData() else { return  }
        self.nameOfFlags = nameFlags
        
        guard let numberPlayers = coreDataManager?.fetchNumberOfPlayersFromCoreData() else { return }
        
        self.numberOfPlayers = numberPlayers
    }
    
    func setupTexts() {
        let backButtonLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
        backButtonLabel.fontColor = .black
        backButtonLabel.numberOfLines = 0
        backButtonLabel.fontSize = 60
        backButtonLabel.text = NSLocalizedString("Back_Button", comment: "Back button text.")
        backButtonLabel.position = CGPoint(x: 120, y: 110)
        backButtonLabel.zPosition = 1
        addChild(backButtonLabel)
        
        let playButtonLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
        playButtonLabel.fontColor = .black
        playButtonLabel.numberOfLines = 0
        playButtonLabel.fontSize = 60
        playButtonLabel.text = NSLocalizedString("Play_Button", comment: "Play button text.")
        playButtonLabel.position = CGPoint(x: 1795, y: 105)
        playButtonLabel.zPosition = 1
        addChild(playButtonLabel)
        
        let chooseGameLabel = SKLabelNode(fontNamed: "Pompiere-Regular")
        chooseGameLabel.fontColor = .black
        chooseGameLabel.fontSize = 50
        chooseGameLabel.text = NSLocalizedString("Ask_Choose_Players", comment: "Asks about which family members will play.")
        chooseGameLabel.position = CGPoint(x: 960, y: 980)
        chooseGameLabel.zPosition = 1
        addChild(chooseGameLabel)
    }
    
    func setupUIButtons() {
        backButton = MenuButtonNode(name: "backButton")
        backButton.position = CGPoint(x: 120, y: 120)
        backButton.zPosition = 0
        addChild(backButton)
        backButton.isUserInteractionEnabled = true
        
        playButton = MenuButtonNode(name: "playButton")
        playButton.position = CGPoint(x: 1775, y: 120)
        playButton.zPosition = 0
        addChild(playButton)
        
    }
    
    func setupTeamButtons() {
        fetchDataFromCoreData()
        let spaceBetweenFlags = 620/Int(numberOfPlayers)
        for i in 0 ..< Int(numberOfPlayers) {
            let flagSelected = MenuButtonNode(name: nameOfFlags[i])
            flagSelected.position = CGPoint(x: 770, y: 680 - (spaceBetweenFlags * i))
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
        
        let signForText = SKSpriteNode(imageNamed: "textSign")
        signForText.size = CGSize(width: self.size.width/2, height: self.size.height/4)
        signForText.position = CGPoint(x: 960, y: 950)
        signForText.zPosition = 0
        addChild(signForText)
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
    
    func pressMenuRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.menuPressed(sender:)))
        tapRecognizer.allowedPressTypes = [NSNumber(value: UIPress.PressType.menu.rawValue)]
        self.view?.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func menuPressed(sender: AnyObject) {
        /* Load Main Menu scene */
        guard let size = view?.frame.size else { return }
        let scene = GameChoices(size: size)
        loadScreens(scene: scene)
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
                    button.position = CGPoint(x: 770, y: button.position.y)
                    button.participating = false
                    participating[i] = 0
                    checkAmountOfPlayers()
                } else {
                    button.position = CGPoint(x: 1130, y: button.position.y)
                    button.participating = true
                    participating[i] = 1
                    checkAmountOfPlayers()
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
        skView.showsFPS = false
        skView.showsNodeCount = false
        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFill
        
        /* 4) Start game scene */
        skView.presentScene(scene)
    }
}
