//
//  TaskNote.swift
//  txtodo
//
//  Created by FIGBERT on 2/28/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import Foundation
import SwiftUI

struct dailyTaskNote: View {
    @EnvironmentObject var globalVars: GlobalVars
    @State var editing: Bool = false
    let taskIndex: Int
    let noteIndex: Int
    let center = NotificationCenter.default
    var body: some View {
        HStack {
            Image(systemName: "minus")
                .font(.system(size: 20, weight: .light))
                .foregroundColor(Color.init(UIColor.label))
                .padding(.trailing, 20)
            if !editing {
                Text(self.globalVars.dailyTasks[self.taskIndex].notes[noteIndex])
                    .onTapGesture(count: 2) {
                        self.editing = true
                    }
                    .font(.system(size: 20, weight: .light))
            } else {
                TextField("editing note", text: $globalVars.dailyTasks[self.taskIndex].notes[noteIndex]) {
                    self.editing = false
                }
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
            }
            Spacer()
        }.padding(.horizontal, 25)
    }
}

struct subTaskNote: View {
    @EnvironmentObject var globalVars: GlobalVars
    @State var editing: Bool = false
    let superIndex: Int
    let subIndex: Int
    let noteIndex: Int
    var body: some View {
        HStack {
            Image(systemName: "minus")
                .font(.system(size: 20, weight: .light))
                .foregroundColor(Color.init(UIColor.label))
                .padding(.trailing, 20)
            if !editing {
                Text(self.globalVars.floatingTasks[superIndex].subTasks[subIndex].notes[noteIndex])
                    .onTapGesture(count: 2) {
                        self.editing = true
                    }
                    .font(.system(size: 20, weight: .light))
            } else {
                TextField("editing note", text: $globalVars.floatingTasks[superIndex].subTasks[subIndex].notes[noteIndex]) {
                    self.editing = false
                }
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
            }
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
                    dailyTaskNote(taskIndex: self.taskIndex, noteIndex: index)
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
                    subTaskNote(superIndex: self.superIndex, subIndex: self.subIndex, noteIndex: index)
                }
                addSubNote(superIndex: superIndex, subIndex: subIndex)
            }
                .padding(.top, 25)
        }
        .navigationBarTitle(Text(globalVars.floatingTasks[superIndex].subTasks[subIndex].main.text), displayMode: .inline)
        .background(Color.init(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
    }
}
