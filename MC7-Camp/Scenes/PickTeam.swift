//
//  PickTeam.swift
//  MC7-Camp
//
//  Created by Paula Leite on 10/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import SpriteKit

enum Selection {
    case none
    case team1
    case team2
}

class PickTeam: SKScene {
    var backButton = MenuButtonNode()
    var buttons = [MenuButtonNode]()
    var flags = [MenuButtonNode]()
    var teamButtons = [MenuButtonNode]()
    var playButton = MenuButtonNode()
    
    var numberOfPlayers = Int()
    var colorName = [String]()
    
    var flag1 = MenuButtonNode()
    var flag2 = MenuButtonNode()
    var flag3 = MenuButtonNode()
    var flag4 = MenuButtonNode()
    var nameOfFlags = [String]()
    
    var flag1Selected = MenuButtonNode()
    var flag2Selected = MenuButtonNode()
    var flag3Selected = MenuButtonNode()
    var flag4Selected = MenuButtonNode()
    var flag1Team = MenuButtonNode()
    var flag2Team = MenuButtonNode()
    var flag3Team = MenuButtonNode()
    var flag4Team = MenuButtonNode()
    
    var user1 = [Any]()
    var user2 = [Any]()
    var user3 = [Any]()
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupUIButtons()
        
        numberOfPlayers = 2
        setupFlags(numberOfPlayers: numberOfPlayers)
        setupTeamButtons(numberOfPlayers: numberOfPlayers)
        
        addTapGestureRecognizer()
    }
    
    func setupFlags(numberOfPlayers: Int) {
        var i = 0
        let nameFlag = "flag"
        while(i < numberOfPlayers) {
            let colorFlag = nameFlag + "\(i + 1)"
            nameOfFlags.append(colorFlag)
            i = i + 1
        }
        
        if numberOfPlayers == 2 {
            flag1 = MenuButtonNode(name: nameOfFlags[0])
            flag1.position = CGPoint(x: 352, y: 725)
            flag1.zPosition = 0
            addChild(flag1)
            flags.append(flag1)
            
            flag2 = MenuButtonNode(name: nameOfFlags[1])
            flag2.position = CGPoint(x: 352, y: 540)
            flag2.zPosition = 0
            addChild(flag2)
        } else {
            flag1 = MenuButtonNode(name: nameOfFlags[0])
            flag1.position = CGPoint(x: 352, y: 725)
            flag1.zPosition = 0
            addChild(flag1)
            flags.append(flag1)
            
            flag2 = MenuButtonNode(name: nameOfFlags[1])
            flag2.position = CGPoint(x: 352, y: 540)
            flag2.zPosition = 0
            addChild(flag2)
            flags.append(flag2)
            
            flag3 = MenuButtonNode(name: nameOfFlags[2])
            flag3.position = CGPoint(x: 352, y: 353)
            flag3.zPosition = 0
            addChild(flag3)
        }
    }
    
    func setupUIButtons() {
        backButton = MenuButtonNode(name: "backButton")
        backButton.position = CGPoint(x: 90, y: 102.5)
        backButton.zPosition = 0
        addChild(backButton)
        buttons.append(backButton)
        
        playButton = MenuButtonNode(name: "playButton@1x")
        playButton.position = CGPoint(x: 1773, y: 186.5)
        playButton.zPosition = 0
        addChild(playButton)
        buttons.append(playButton)
        
        for button in buttons {
            button.isUserInteractionEnabled = true
        }
    }
    
    func setupTeamButtons(numberOfPlayers: Int) {
        var i = 0
        let nameFlag = "flag"
        while(i < numberOfPlayers) {
            let colorFlag = nameFlag + "\(i + 1)"
            nameOfFlags.append(colorFlag)
            i = i + 1
        }
        
        if numberOfPlayers == 2 {
            flag1Team = MenuButtonNode(name: "botaoTime")
            flag1Team.position = CGPoint(x: 1219, y: 700)
            flag1Team.zPosition = 0
            addChild(flag1Team)
            teamButtons.append(flag1Team)
            flag1Team.selectedTeam1 = true
            
            flag1Selected = MenuButtonNode(name: "button_selected")
            flag1Selected.position = CGPoint(x: 992.5, y: 700)
            flag1Selected.zPosition = 1
            addChild(flag1Selected)
            
            flag2Team = MenuButtonNode(name: "botaoTime")
            flag2Team.position = CGPoint(x: 1219, y: 519)
            flag2Team.zPosition = 0
            addChild(flag2Team)
            teamButtons.append(flag2Team)
            flag2Team.selectedTeam1 = true
            
            flag2Selected = MenuButtonNode(name: "button_selected")
            flag2Selected.position = CGPoint(x: 992.5, y: 519)
            flag2Selected.zPosition = 1
            addChild(flag2Selected)
        } else {
            flag1Team = MenuButtonNode(name: "botaoTime")
            flag1Team.position = CGPoint(x: 1219, y: 700)
            flag1Team.zPosition = 0
            addChild(flag1Team)
            teamButtons.append(flag1Team)
            flag1Team.selectedTeam1 = true
            
            flag1Selected = MenuButtonNode(name: "button_selected")
            flag1Selected.position = CGPoint(x: 992.5, y: 700)
            flag1Selected.zPosition = 1
            addChild(flag1Selected)
            
            flag2Team = MenuButtonNode(name: "botaoTime")
            flag2Team.position = CGPoint(x: 1219, y: 519)
            flag2Team.zPosition = 0
            addChild(flag2Team)
            teamButtons.append(flag2Team)
            flag2Team.selectedTeam1 = true
            
            flag2Selected = MenuButtonNode(name: "button_selected")
            flag2Selected.position = CGPoint(x: 992.5, y: 519)
            flag2Selected.zPosition = 1
            addChild(flag2Selected)
            
            flag3Team = MenuButtonNode(name: "botaoTime")
            flag3Team.position = CGPoint(x: 1219, y: 344)
            flag3Team.zPosition = 0
            addChild(flag3Team)
            teamButtons.append(flag3Team)
            flag3Team.selectedTeam1 = true
            
            flag3Selected = MenuButtonNode(name: "button_selected")
            flag3Selected.position = CGPoint(x: 992.5, y: 344)
            flag3Selected.zPosition = 1
            addChild(flag3Selected)
        }
        
        for teamButton in teamButtons {
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
            if focussedItem == backButton {
                /* Load Game Choices scene */
                guard let size = view?.frame.size else { return }
                let scene = GameChoices(size: size)
                loadScreens(scene: scene)
            } else if focussedItem == playButton {
                /* Load BallGame scene */
                guard let size = view?.frame.size else { return }
                let scene = BallGame(size: size)
                // I need to send which players are playing.
                loadScreens(scene: scene)
            } else if focussedItem == flag1Team {
                if flag1Team.selectedTeam1 == true {
                    flag1Selected.position = CGPoint(x: 1440, y: 700)
                    flag1Team.selectedTeam1 = false
                } else {
                    flag1Selected.position = CGPoint(x: 992.5, y: 700)
                    flag1Team.selectedTeam1 = true
                }
            } else if focussedItem == flag2Team {
                if flag2Team.selectedTeam1 == true {
                    flag2Selected.position = CGPoint(x: 1440, y: 519)
                    flag2Team.selectedTeam1 = false
                } else {
                    flag2Selected.position = CGPoint(x: 992.5, y: 519)
                    flag2Team.selectedTeam1 = true
                }
            } else if focussedItem == flag3Team {
                if flag3Team.selectedTeam1 == true {
                    flag3Selected.position = CGPoint(x: 1440, y: 344)
                    flag3Team.selectedTeam1 = false
                } else {
                    flag3Selected.position = CGPoint(x: 992.5, y: 344)
                    flag3Team.selectedTeam1 = true
                }
            }
        }
        print("tapped")
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
