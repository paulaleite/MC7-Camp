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
            
            familyMembers = orderFamilyMembers(familyMembers: familyMembers)
            
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
        
        return nameOfShacks.reversed()
    }
    
    func fetchFlagsFromCoreData() -> [String] {
        
        do {
            guard let context = context else { return ["Error with context"] }
            
            families = try context.fetch(Family.fetchRequest())
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            
            familyMembers = orderFamilyMembers(familyMembers: familyMembers)
            
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
        
        return nameOfFlags
    }
    
    func fetchNumberOfPlayersFromCoreData() -> Int64 {
        
        do {
            guard let context = context else { return 0 }
            
            families = try context.fetch(Family.fetchRequest())
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            
            familyMembers = orderFamilyMembers(familyMembers: familyMembers)
            
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
            
            familyMembers = orderFamilyMembers(familyMembers: familyMembers)
            
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
            
            familyMembers = orderFamilyMembers(familyMembers: familyMembers)
            
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
            
            familyMembers = orderFamilyMembers(familyMembers: familyMembers)
            
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
            
            familyMembers = orderFamilyMembers(familyMembers: familyMembers)
            
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
            
            familyMembers = orderFamilyMembers(familyMembers: familyMembers)
            
            for i in 0 ..< familyMemberIndexes.count {
                self.numberOfTimesPlayed.append(familyMembers[i].timesPlayedMessGame)
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        return numberOfTimesPlayed
    }
    
    func fetchBadgesWon(players: [Int]) -> [String] {
        do {
            guard let context = context else { return ["Error"] }
            
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            
            familyMembers = orderFamilyMembers(familyMembers: familyMembers)
            
            for j in 0 ..< players.count {
                guard let amountOfBadges = familyMembers[players[j]].reward?.count else { return ["Not found amount of badges."] }
                guard let playerRewards = familyMembers[players[j]].reward?.array as? [Reward] else { return ["Couldn't get rewards"] }
                guard let rewardImages = playerRewards[amountOfBadges - 1].imageName else { return ["Couldn't get image names"] }
                self.badgesWon.append(rewardImages)
            }
            
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        return badgesWon
    }
    
    func fetchPlayerBadges(player: Int) -> [String] {
        do {
            
            guard let context = context else { return ["Error"] }
            
            familyMembers = try context.fetch(FamilyMember.fetchRequest())
            
            familyMembers = orderFamilyMembers(familyMembers: familyMembers)
            
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
    
    func orderFamilyMembers(familyMembers: [FamilyMember]) -> [FamilyMember] {
        var familyMembersCorrected = [FamilyMember?](repeating: nil, count: 6)
        
        for familyMember in familyMembers {
            guard let familyMemberSufix = familyMember.flagName?.suffix(1) else { return [FamilyMember]()}
            guard let sufix = Int(familyMemberSufix) else { return [FamilyMember]() }
            
            familyMembersCorrected[sufix - 1] = familyMember
        }
        
        return familyMembersCorrected.compactMap({
            $0
        })
    }
}



