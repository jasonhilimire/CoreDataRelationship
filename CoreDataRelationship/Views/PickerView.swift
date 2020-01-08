//
//  PickerView.swift
//  CoreDataRelationship
//
//  Created by Jason Hilimire on 1/8/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI
import Combine

struct PickerView: View {
    
        @State private var raceName = ""
        @State private var raceLocation = ""
        @State private var stage = ""
        @State private var stageNum = 0
    
    @ObservedObject var lastStage = StageModel()
  
    
    // Create the MOC
    @Environment(\.managedObjectContext) var moc
    // create a Fetch request for Race
    @FetchRequest(entity: Race.entity(), sortDescriptors: []) var races: FetchedResults<Race>
    
    // create a Fetch request for Race
    @FetchRequest(entity: Stage.entity(), sortDescriptors: []) var stages: FetchedResults<Stage>
   // Go find the last record and a value
    var lastStageNum: Int  {
        if let lastRecord = stages.last {
                let lastRecordStage = lastRecord.value(forKey: "stageNum")
                return lastRecordStage as! Int
            } else {
                print("didnt find last record")
                return 55
            }
    }
    

    var body: some View {
        VStack {
            Form{
                // for each race we find in the races FetchResults show the race.wrappedName in the pickerview - when selected assign it to location
                Picker(selection: $raceName, label: Text("Race Name")) {
                    ForEach(races, id: \.self) { race in Text(race.wrappedName).tag(race.wrappedName)}
                    }
                TextField("Location", text: $raceLocation)
                    TextField("Enter Stage", text: $stage)
                Stepper(value: $stageNum, in: 0...12, label: {Text("Stage #: \(stageNum)")})
                    .onAppear {
                        // Will find the value correctly
                        print("Found last stagenum: \(self.lastStageNum)")
                        print("Computed stageNum: \(self.stages.last?.stageNum)")
                        //Crashes when looking in the model for the value
//                        print("StageModel : \(self.lastStage.printLastStage())")
                    }
            }
            
            // This ADD button creates a new stage using the entered stage Name from the form and links it to the Race Correctly from the Picker
            Button("ADD") {
                let newStage = Stage(context: self.moc)
                newStage.stageName = self.stage
                newStage.stageNum = Int16(self.stageNum)
                newStage.race = Race(context: self.moc)
                
                newStage.race?.raceName = self.raceName
                newStage.race?.location = self.raceLocation
                try? self.moc.save()
                
                print(newStage)
            }
        }
        
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
    }
}
