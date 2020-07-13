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
    
    var numberOfPlayers = Int()
    var colorName = [String]()
    
    var flag1 = MenuButtonNode()
    var flag2 = MenuButtonNode()
    var flag3 = MenuButtonNode()
    var flag4 = MenuButtonNode()
    var nameOfFlags = [String]()
    
    var team1flag1 = MenuButtonNode()
    var team1flag2 = MenuButtonNode()
    var team1flag3 = MenuButtonNode()
    var team1flag4 = MenuButtonNode()
    var team2flag1 = MenuButtonNode()
    var team2flag2 = MenuButtonNode()
    var team2flag3 = MenuButtonNode()
    var team2flag4 = MenuButtonNode()
    
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
            team1flag1 = MenuButtonNode(name: "button_selected")
            team1flag1.position = CGPoint(x: 1020, y: 726)
            team1flag1.zPosition = 0
            addChild(team1flag1)
            teamButtons.append(team1flag1)
            
            team2flag1 = MenuButtonNode(name: "button_no_selection")
            team2flag1.position = CGPoint(x: 1500, y: 726)
            team2flag1.zPosition = 0
            addChild(team2flag1)
            teamButtons.append(team2flag1)
            
            user1 = [team1flag1, team2flag1, Selection.none]
            
            team1flag2 = MenuButtonNode(name: "button_selected")
            team1flag2.position = CGPoint(x: 1020, y: 540)
            team1flag2.zPosition = 0
            addChild(team1flag2)
            teamButtons.append(team1flag2)
            
            team2flag2 = MenuButtonNode(name: "button_no_selection")
            team2flag2.position = CGPoint(x: 1500, y: 540)
            team2flag2.zPosition = 0
            addChild(team2flag2)
            teamButtons.append(team2flag2)
            
            user2 = [team1flag2, team2flag2, Selection.none]
            
        } else {
            team1flag1 = MenuButtonNode(name: "button_no_selection")
            team1flag1.position = CGPoint(x: 1020, y: 726)
            team1flag1.zPosition = 0
            addChild(team1flag1)
            teamButtons.append(team1flag1)
            
            team1flag2 = MenuButtonNode(name: "button_no_selection")
            team1flag2.position = CGPoint(x: 1020, y: 540)
            team1flag2.zPosition = 0
            addChild(team1flag2)
            teamButtons.append(team1flag2)
            
            team1flag3 = MenuButtonNode(name: "button_no_selection")
            team1flag3.position = CGPoint(x: 1020, y: 362)
            team1flag3.zPosition = 0
            addChild(team1flag3)
            teamButtons.append(team1flag3)
            
            team2flag1 = MenuButtonNode(name: "button_no_selection")
            team2flag1.position = CGPoint(x: 1500, y: 726)
            team2flag1.zPosition = 0
            addChild(team2flag1)
            teamButtons.append(team2flag1)
            
            team2flag2 = MenuButtonNode(name: "button_no_selection")
            team2flag2.position = CGPoint(x: 1500, y: 540)
            team2flag2.zPosition = 0
            addChild(team2flag2)
            teamButtons.append(team2flag2)
            
            team2flag3 = MenuButtonNode(name: "button_no_selection")
            team2flag3.position = CGPoint(x: 1500, y: 362)
            team2flag3.zPosition = 0
            addChild(team2flag3)
            teamButtons.append(team2flag3)
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
            //            setupRightSwipedGestureRecognizer(flag: flag1)
            //            setupLeftSwipedGestureRecognizer(flag: flag1)
            if focussedItem == backButton {
                /* Load Game Choices scene */
                guard let size = view?.frame.size else { return }
                let scene = GameChoices(size: size)
                print("Could not make Game Choices, check the name is spelled correctly")
                loadScreens(scene: scene)
            } else if focussedItem == team2flag1 && (team1flag1.texture ==  SKTexture(imageNamed: "button_selected") || team1flag1.texture ==  nil){
                changeButtonSelection(button1: focussedItem, button2: team1flag1)
//                user1 = [team1flag1, team2flag1, Selection.team1]
            }
        }
        print("tapped")
    }
    
    func changeButtonSelection(button1: MenuButtonNode, button2: MenuButtonNode) {
        let texture = SKTexture(imageNamed: "button_selected")
        let changesTexture = SKAction.setTexture(texture, resize: false)
        button1.run(changesTexture)
        
        let texture2 = SKTexture(imageNamed: "button_no_selection")
        let changesTexture2 = SKAction.setTexture(texture2, resize: false)
        button2.run(changesTexture2)
    }
    
    //    func setupRightSwipedGestureRecognizer(flag: MenuButtonNode) {
    //        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
    //        swipeRecognizer.direction = .right
    //        view?.addGestureRecognizer(swipeRecognizer)
    //    }
    //
    //    func setupLeftSwipedGestureRecognizer(flag: MenuButtonNode) {
    //        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
    //        swipeRecognizer.direction = .left
    //        view?.addGestureRecognizer(swipeRecognizer)
    //    }
    //
    //    @objc func swipedRight() {
    //        print("Swiped right")
    //
    //        if let focussedItem = UIScreen.main.focusedItem as? MenuButtonNode {
    //            if focussedItem == flag1 {
    //                flag1.position = CGPoint(x: 1654, y: 540)
    //                print("Flag 1 selected")
    //            } else if focussedItem == flag2 {
    //
    //                print("Flag 2 selected")
    //            } else {
    //                print("Flag 3 selected")
    //            }
    //        }
    //
    //    }
    //
    //    @objc func swipedLeft() {
    //        print("Swiped left")
    //
    //
    //        if let focussedItem = UIScreen.main.focusedItem as? MenuButtonNode {
    //            if focussedItem == flag1 {
    //                flag1.position = CGPoint(x: 335, y: 540)
    //                print("Flag 1 selected")
    //            } else if focussedItem == flag2 {
    //                print("Flag 2 selected")
    //
    //            } else {
    //                print("Flag 3 selected")
    //            }
    //        }
    //
    //
    //    }
    
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
