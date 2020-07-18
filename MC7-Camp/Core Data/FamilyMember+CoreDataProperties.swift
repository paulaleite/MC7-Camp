//
//  FamilyMember+CoreDataProperties.swift
//  MC7-Camp
//
//  Created by Paula Leite on 17/07/20.
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
    @NSManaged public var family: Family?
    @NSManaged public var reward: Reward?

}
