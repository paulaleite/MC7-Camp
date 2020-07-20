//
//  CoreDataManeger.swift
//  MC7-Camp
//
//  Created by Paula Leite on 17/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    var familyMembers: [FamilyMember] = []
    var familyMember: FamilyMember?
    var families: [Family] = []
    var family: Family?
    var rewards: [Reward] = []
    var reward: Reward?
    
    var context: NSManagedObjectContext?
    
    var nameOfShacks = [String]()
    var nameOfFlags = [String]()
    var numberOfPlayers = Int64()
    
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.context = context
    }
    
    func fetchShacksFromCoreData() -> [String] {
        
        do {
            guard let context = context else { return ["Error with context"] }
            
            families = try context.fetch(Family.fetchRequest())
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            
            guard families.count > 0 else {
                return ["Error with family count"]
            }
            
            var i = 0
            while i < families[0].numberOfFamilyMembers {
                guard let memberShack = familyMembers[i].shackName else { return ["Error with name of shacks"] }
                nameOfShacks.append(memberShack)
                i = i + 1
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        return nameOfShacks
    }
    
    func fetchFlagsFromCoreData() -> [String] {
        
        do {
            guard let context = context else { return ["Error with context"] }
            
            families = try context.fetch(Family.fetchRequest())
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            
            guard families.count > 0 else {
                return ["Error with family count"]
            }
            
            var i = 0
            while i < families[0].numberOfFamilyMembers {
                guard let memberFlag = familyMembers[i].flagName else { return ["Error with name of shacks"] }
                nameOfFlags.append(memberFlag)
                i = i + 1
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        return nameOfFlags.reversed()
    }
    
    func fetchNumberOfPlayersFromCoreData() -> Int64 {
        
        do {
            guard let context = context else { return 0 }
            
            families = try context.fetch(Family.fetchRequest())
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            
            guard families.count > 0 else {
                return 1
            }
            self.numberOfPlayers = families[0].numberOfFamilyMembers
            
            return numberOfPlayers
        } catch let error {
            print(error.localizedDescription)
        }
        
        return numberOfPlayers
    }
    
    func addRewardToFamilyMember(familyMemberIndexes: [Int]) {
        
        do {
            guard let context = context else { return }
            
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            for i in 0 ..< familyMemberIndexes.count {
                //
            }
            
            guard let reward = NSEntityDescription.insertNewObject(forEntityName: "Reard", into: context) as? Reward else { return }
        
            
        } catch let error {
            print(error.localizedDescription)
        }
    
    }
    
    func addToTimesPlayedBasketballGame() {
        do {
            guard let context = context else { return }
            
            families = try context.fetch(Family.fetchRequest())
            
            families[0].timesPlayedBasketballGame += 1
        
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func addToTimesPlayedMessGame() {
        do {
            guard let context = context else { return }
            
            families = try context.fetch(Family.fetchRequest())
            
            families[0].timesPlayedMessGame += 1
        
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
