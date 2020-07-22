//
//  FamilyMember+CoreDataProperties.swift
//  MC7-Camp
//
//  Created by Paula Leite on 22/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//
//

import Foundation
import CoreData


extension FamilyMember {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FamilyMember> {
        return NSFetchRequest<FamilyMember>(entityName: "FamilyMember")
    }

    @NSManaged public var flagName: String?
    @NSManaged public var shackName: String?
    @NSManaged public var timesPlayedBasketballGame: Double
    @NSManaged public var timesPlayedMessGame: Double
    @NSManaged public var family: Family?
    @NSManaged public var reward: NSOrderedSet?

}

// MARK: Generated accessors for reward
extension FamilyMember {

    @objc(insertObject:inRewardAtIndex:)
    @NSManaged public func insertIntoReward(_ value: Reward, at idx: Int)

    @objc(removeObjectFromRewardAtIndex:)
    @NSManaged public func removeFromReward(at idx: Int)

    @objc(insertReward:atIndexes:)
    @NSManaged public func insertIntoReward(_ values: [Reward], at indexes: NSIndexSet)

    @objc(removeRewardAtIndexes:)
    @NSManaged public func removeFromReward(at indexes: NSIndexSet)

    @objc(replaceObjectInRewardAtIndex:withObject:)
    @NSManaged public func replaceReward(at idx: Int, with value: Reward)

    @objc(replaceRewardAtIndexes:withReward:)
    @NSManaged public func replaceReward(at indexes: NSIndexSet, with values: [Reward])

    @objc(addRewardObject:)
    @NSManaged public func addToReward(_ value: Reward)

    @objc(removeRewardObject:)
    @NSManaged public func removeFromReward(_ value: Reward)

    @objc(addReward:)
    @NSManaged public func addToReward(_ values: NSOrderedSet)

    @objc(removeReward:)
    @NSManaged public func removeFromReward(_ values: NSOrderedSet)

}
