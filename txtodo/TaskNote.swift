//
//  TaskNote.swift
//  txtodo
//
//  Created by FIGBERT on 2/28/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import Foundation
import SwiftUI

struct taskNote: View {
    @State var note: String
    var body: some View {
        HStack {
            Image(systemName: "minus")
                .font(.system(size: 20, weight: .light))
                .foregroundColor(Color.init(UIColor.label))
                .padding(.trailing, 20)
            Text(note)
                .font(.system(size: 20, weight: .light))
            Spacer()
        }.padding(.horizontal, 25)
    }
}

struct taskNotes: View {
    @EnvironmentObject var globalVars: GlobalVars
    let taskIndex: Int
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(globalVars.dailyTasks[taskIndex].notes.indices, id: \.self) { index in
                    taskNote(note: self.globalVars.dailyTasks[self.taskIndex].notes[index])
                }
                addNote(taskIndex: taskIndex)
            }
                .padding(.top, 25)
        }
        .navigationBarTitle(Text(globalVars.dailyTasks[taskIndex].main.text), displayMode: .inline)
        .background(Color.init(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
    }
}

struct subTaskNotes: View {
    @EnvironmentObject var globalVars: GlobalVars
    let superIndex: Int
    let subIndex: Int
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(globalVars.floatingTasks[superIndex].subTasks[subIndex].notes.indices, id: \.self) { index in
                    taskNote(note: self.globalVars.floatingTasks[self.superIndex].subTasks[self.subIndex].notes[index])
                }
                addSubNote(superIndex: superIndex, subIndex: subIndex)
            }
                .padding(.top, 25)
        }
        .navigationBarTitle(Text(globalVars.floatingTasks[superIndex].subTasks[subIndex].main.text), displayMode: .inline)
        .background(Color.init(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
    }
}
