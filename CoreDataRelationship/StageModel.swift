//
//  StageModel.swift
//  CoreDataRelationship
//
//  Created by Jason Hilimire on 1/8/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class StageModel: ObservableObject {
    @FetchRequest(entity: Stage.entity(), sortDescriptors: []) var stages: FetchedResults<Stage>
    
    @Published var lastStageNum: Int16 = 1
    

    var lastStageNumVar: Int16  {
        //Exception occurs here
        if let lastRecord = stages.last {
            let lastRecordStage = lastRecord.value(forKey: "stageNum")
                   return lastRecordStage as! Int16
               } else {
                   print("didnt find last record")
                   return 55
               }
       }

    func printLastStage() {
        print("Last Stage = \(lastStageNumVar)")
    }
    
    func getLastStage() {
        self.lastStageNum = self.lastStageNumVar
    }

}

