//
//  FamilyMember+CoreDataProperties.swift
//  MC7-Camp
//
//  Created by Paula Leite on 21/07/20.
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
    @NSManaged public var reward: Reward?

}
