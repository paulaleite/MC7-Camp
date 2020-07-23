//
//  PickTeam.swift
//  MC7-Camp
//
//  Created by Paula Leite on 10/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import SpriteKit
import CoreData

class PickTeam: SKScene {
    var nameGameChosen = String()
    var participating = [Int]()
    var playersParticipating = 0
    
    var backButton = MenuButtonNode()
    var buttons = [MenuButtonNode]()
    var playButton = MenuButtonNode()
    
    var teamButtons = [MenuButtonNode]()
    var flagButtons = [MenuButtonNode]()
    
    var teamPerson = [Int]()
    var numberOfPlayers = Int64()
    var nameOfFlags = [String]()
    var activeFlags = [String]()
    var context: NSManagedObjectContext?
    var coreDataManager: CoreDataManager?
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupUIButtons()
        
        setupTeamButtons(peopleParticipating: participating)
        
        addTapGestureRecognizer()
    }
    
    func setupUIButtons() {
        backButton = MenuButtonNode(name: "backButton")
        backButton.position = CGPoint(x: 120, y: 120)
        backButton.zPosition = 0
        addChild(backButton)
        buttons.append(backButton)
        
        playButton = MenuButtonNode(name: "playButton@")
        playButton.position = CGPoint(x: 1800, y: 120)
        playButton.zPosition = 0
        addChild(playButton)
        buttons.append(playButton)
        
        for button in buttons {
            button.isUserInteractionEnabled = true
        }
    }
    
    func fetchDataFromCoreData() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        coreDataManager = CoreDataManager(context: context!)
        
        guard let nameFlags = coreDataManager?.fetchFlagsFromCoreData() else { return  }
        self.nameOfFlags = nameFlags
    }
    
    func setupTeamButtons(peopleParticipating: [Int]) {
        fetchDataFromCoreData()
        
        var i = 0
        while(i < participating.count) {
            if participating[i] == 1 {
                activeFlags.append(nameOfFlags[i])
                playersParticipating += 1
            }
            i = i + 1
        }
        
        for i in 0 ..< activeFlags.count {
            let flagSelected = MenuButtonNode(name: activeFlags[i])
            flagSelected.position = CGPoint(x: 761, y: 600 - (180  * i))
            flagSelected.zPosition = 1
            addChild(flagSelected)
            flagButtons.append(flagSelected)
            flagSelected.selectedTeam1 = true
            
            teamPerson.append(1)
        }
        
        for teamButton in flagButtons {
            teamButton.isUserInteractionEnabled = true
        }
    }
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "chooseTeam")
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
            for i in 0 ..< flagButtons.count {
                let button = flagButtons[i]
                if button != focussedItem {
                    continue
                }
                if button.selectedTeam1 == true {
                    button.position = CGPoint(x: 1208, y: button.position.y)
                    button.selectedTeam1 = false
                    teamPerson[i] = 2
                } else {
                    button.position = CGPoint(x: 761, y: button.position.y)
                    button.selectedTeam1 = true
                    teamPerson[i] = 1
                }
            }
            
            if focussedItem == backButton {
                /* Load Game Choices scene */
                guard let size = view?.frame.size else { return }
                let scene = GameChoices(size: size)
                loadScreens(scene: scene)
            } else if focussedItem == playButton {
                /* Load MessGame scene *//* Load Colaborative GAme scene */
                guard let size = view?.frame.size else { return }
                let scene = CompetetiveGame(size: size)
                scene.teamPerson = self.teamPerson
                // I need to send which players are playing.
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
