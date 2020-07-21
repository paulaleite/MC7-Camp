//
//  Family+CoreDataProperties.swift
//  MC7-Camp
//
//  Created by Paula Leite on 21/07/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//
//

import Foundation
import CoreData


extension Family {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Family> {
        return NSFetchRequest<Family>(entityName: "Family")
    }

    @NSManaged public var familyName: String?
    @NSManaged public var numberOfFamilyMembers: Int64
    @NSManaged public var familyMember: FamilyMember?

}
