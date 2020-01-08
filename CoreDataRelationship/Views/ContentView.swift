//
//  ContentView.swift
//  CoreDataRelationship
//
//  Created by Jason Hilimire on 1/8/20.
//  Copyright © 2020 Jason Hilimire. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // Create the MOC
    @Environment(\.managedObjectContext) var moc
    // create a Fetch request for Race
    @FetchRequest(entity: Race.entity(), sortDescriptors: []) var races: FetchedResults<Race>
    
    var body: some View {
        
           //TODO: ensure the merge policy is added to the Scene Delegate & constraint in CoreData model is configured if want Section Headers to roll up
        NavigationView{
            VStack {
                NavigationLink(destination: PickerView()) {
                    Text("Show Picker view")
                }
                List {
                    ForEach(races, id: \.self) { race in
                        Section(header: Text(race.wrappedName)) {
                            ForEach(race.stageArray, id: \.self) {stage in
                                Text(stage.wrappedStageName)
                            }
                        }
                    }
                }
               
                Button("Add") {
                    let stage1 = Stage(context: self.moc)
                    stage1.stageName = "Blinder"
                    stage1.stageNum = 1
                    stage1.race = Race(context: self.moc)
                    
                    stage1.race?.raceName = "Steamboat"
                    stage1.race?.location = "Steamboat Springs"
                    
                    let stage2 = Stage(context: self.moc)
                    stage2.stageName = "Cowboy Up"
                    stage2.stageNum = 2
                    stage2.race = Race(context: self.moc)
                    
                    stage2.race?.raceName = "Steamboat"
                    stage2.race?.location = "Steamboat Springs"
                    
                    let stage3 = Stage(context: self.moc)
                    stage3.stageName = "River Trail"
                    stage3.stageNum = 3
                    stage3.race = Race(context: self.moc)
                    
                    stage3.race?.raceName = "Steamboat"
                    stage3.race?.location = "BackCountry"
                    
                    let stage4 = Stage(context: self.moc)
                    stage4.stageName = "Trestle DH"
                    stage4.stageNum = 1
                    stage4.race = Race(context: self.moc)
                    
                    stage4.race?.raceName = "Trestle BME"
                    stage4.race?.location = "Winter Park"
                    
                    let stage5 = Stage(context: self.moc)
                    stage5.stageName = "Mountain Goat"
                    stage5.stageNum = 2
                    stage5.race = Race(context: self.moc)
                    
                    stage5.race?.raceName = "Trestle BME"
                    stage5.race?.location = "Winter Park"
                    
                    try? self.moc.save()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
