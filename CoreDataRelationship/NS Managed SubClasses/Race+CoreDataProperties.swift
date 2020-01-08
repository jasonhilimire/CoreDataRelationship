//
//  Race+CoreDataProperties.swift
//  CoreDataRelationship
//
//  Created by Jason Hilimire on 1/8/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//
//

import Foundation
import CoreData


extension Race {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Race> {
        return NSFetchRequest<Race>(entityName: "Race")
    }

    @NSManaged public var location: String?
    @NSManaged public var raceName: String?
    @NSManaged public var stages: Stage?
    
    // Wrap the optionals with defaults so they are never nil
    public var wrappedName: String {
        raceName ?? "Unknown Race"
    }
    
    public var wrappedLocation: String {
        location ?? "Unknown Location"
    }
    
    //  Convert from an NSSet to Set, convert Set to an Array so that ForEach can read data, then Sort Array (do really need sort if use Ordered?
    public var stageArray: [Stage] {
        let set = stages as? Set<Stage> ?? []
        return set.sorted {
            $0.wrappedStageName < $1.wrappedStageName
        }
    }

}
