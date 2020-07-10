//
//  GameChoices.swift
//  MC7-Camp
//
//  Created by Paula Leite on 08/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class GameChoices: SKScene {
    var buttons = [MenuButtonNode]()
    var backButton = MenuButtonNode()
    var messGameButton = MenuButtonNode()
    var ballGameButton = MenuButtonNode()
    
    override func didMove(to view: SKView) {
        print("Inside Game Choices.")
        setupBackground()
        setupButtons()
        
        addTapGestureRecognizer()
    }
    
    func setupBackground() {
        let background = SKSpriteNode(imageNamed: "chooseGame")
        background.position = CGPoint(x: 960, y: 540)
        background.zPosition = -1
        addChild(background)
    }
    
    func setupButtons() {
        backButton = MenuButtonNode(name: "backButton")
        backButton.position = CGPoint(x: 90, y: 102.5)
        backButton.zPosition = 0
        addChild(backButton)
        buttons.append(backButton)
        
        messGameButton = MenuButtonNode(name: "messButton")
        messGameButton.position = CGPoint(x: 805.5, y: 231)
        messGameButton.zPosition = 0
        addChild(messGameButton)
        buttons.append(messGameButton)
        
        ballGameButton = MenuButtonNode(name: "ballGameButton")
        ballGameButton.position = CGPoint(x: 1186.5, y: 282)
        ballGameButton.zPosition = 0
        addChild(ballGameButton)
        buttons.append(ballGameButton)
        
        for button in buttons {
            button.isUserInteractionEnabled = true
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
            if focussedItem == backButton {
                /* Load Main scene */
                guard let size = view?.frame.size else { return }
                let scene = MainMenu(size: size)
                print("Could not make MainMenu, check the name is spelled correctly")
                loadScreens(scene: scene)
            } else if focussedItem == messGameButton {
                let alert = UIAlertController(title: "Jogar o Jogo da Bagunça", message: "Você tem certeza de que deseja jogar esse jogo?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { _ in }))
                alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { (_) in
                    //TODO: Aqui deve sair do servidor como membro
                    /* Load Main scene */
                    guard let size = self.view?.frame.size else { return }
                    let scene = PickTeam(size: size)
                    print("Could not make Pick Teams, check the name is spelled correctly")
                    self.loadScreens(scene: scene)
                }))
                if let vc = self.scene?.view?.window?.rootViewController {
                    vc.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Jogar o Jogo de Basquete", message: "Você tem certeza de que deseja jogar esse jogo?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { _ in }))
                alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { (_) in
                    //TODO: Aqui deve sair do servidor como membro
                    /* Load Main scene */
                    guard let size = self.view?.frame.size else { return }
                    let scene = BallGame(size: size)
                    print("Could not make BallGame, check the name is spelled correctly")
                    self.loadScreens(scene: scene)
                }))
                if let vc = self.scene?.view?.window?.rootViewController {
                    vc.present(alert, animated: true, completion: nil)
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
