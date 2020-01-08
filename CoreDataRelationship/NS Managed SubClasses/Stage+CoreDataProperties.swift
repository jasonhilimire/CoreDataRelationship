//
//  Stage+CoreDataProperties.swift
//  CoreDataRelationship
//
//  Created by Jason Hilimire on 1/8/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//
//

import Foundation
import CoreData


extension Stage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stage> {
        return NSFetchRequest<Stage>(entityName: "Stage")
    }

    @NSManaged public var stageName: String?
    @NSManaged public var stageNum: Int16
    @NSManaged public var race: Race?
    
    public var wrappedStageName: String {
        stageName ?? "Unknown Stage Name"
    }

}
