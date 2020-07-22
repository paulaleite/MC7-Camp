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
    var numberOfTimesPlayed = [Double]()
    var badgesWon = [String]()
    
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
    
    func addRewardToFamilyMember(familyMemberIndex: Int, rewardImageName: String, application: AppDelegate) {
        
        do {
            guard let context = context else { return }
            
            rewards = try context.fetch(Reward.fetchRequest())
            
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            
            guard let reward = NSEntityDescription.insertNewObject(forEntityName: "Reward", into: context) as? Reward else { return }
            
            reward.imageName = rewardImageName
            reward.familyMember = familyMembers[familyMemberIndex]
            rewards.append(reward)
    
            familyMembers[familyMemberIndex].addToReward(reward)
            
            application.saveContext()
        } catch let error {
            print(error.localizedDescription)
        }
    
    }
    
    func addToTimesPlayedBasketballGame(familyMemberIndexes: [Int], application: AppDelegate) {
        do {
            guard let context = context else { return }
            
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            
            for i in 0 ..< familyMemberIndexes.count {
                let index = familyMemberIndexes[i]
                familyMembers[index].timesPlayedBasketballGame += 1.0
                
            }
            application.saveContext()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func fetchTimesPlayedBasketballGame(familyMemberIndexes: [Int]) -> [Double] {
        do {
            
            guard let context = context else { return [1] }
            
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            
            for i in 0 ..< familyMemberIndexes.count {
                let index = familyMemberIndexes[i]
                self.numberOfTimesPlayed.append(familyMembers[index].timesPlayedBasketballGame)
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        return numberOfTimesPlayed
    }
    
    func addToTimesPlayedMessGame(familyMemberIndexes: [Int], application: AppDelegate) {
        do {
            guard let context = context else { return }
            
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            
            for i in 0 ..< familyMemberIndexes.count {
                if familyMemberIndexes[i] == 1 {
                    familyMembers[i].timesPlayedMessGame += 1.0
                }
            }
            application.saveContext()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func fetchTimesPlayedMessGame(familyMemberIndexes: [Int]) -> [Double] {
        do {
            
            guard let context = context else { return [1] }
            
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            
            for i in 0 ..< familyMemberIndexes.count {
                self.numberOfTimesPlayed.append(familyMembers[i].timesPlayedMessGame)
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        return numberOfTimesPlayed
    }
    
//    func fetchBadgesWon(players: [Int]) -> [String] {
//        do {
//            guard let context = context else { return ["Error"] }
//            
//            familyMembers = try context.fetch(FamilyMember.fetchRequest())
//            
//            for i in 0 ..< players.count {
//                
//                guard let reward = familyMembers[i].reward else { return ["Image not found"] }
//                
//                self.badgesWon.append(reward)
//            }
//            
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        
//        return badgesWon
//    }
    
    func fetchPlayerBadges(player: Int) -> [String] {
        do {
            
            guard let context = context else { return ["Error"] }
            
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            rewards = try context.fetch(Reward.fetchRequest())
            
            guard let amountOfBadges = familyMembers[player].reward?.count else { return ["Not found amount of badges."] }
            guard let playerRewards = familyMembers[player].reward?.array as? [Reward] else { return ["Couldn't get rewards"] }
            
            for i in 0 ..< amountOfBadges {
                guard let rewardImages = playerRewards[i].imageName else { return ["Couldn't get image names"] }
                self.badgesWon.append(rewardImages)
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        return badgesWon
    }
}
