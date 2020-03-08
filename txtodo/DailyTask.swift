//
//  DailyTask.swift
//  txtodo
//
//  Created by FIGBERT on 2/28/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import Foundation
import SwiftUI

struct dailyTaskView: View {
    @EnvironmentObject var globalVars: GlobalVars
    @State var editing: Bool = false
    @State var viewingNotes: Bool = false
    @State var confirmingDelete: Bool = false
    @State var deleted: Bool = false
    let taskIndex: Int
    var body: some View {
        HStack {
            if !deleted {
                Button(action: {
                    self.globalVars.dailyTasks[self.taskIndex].main.complete.toggle()
                }) {
                    if globalVars.dailyTasks[taskIndex].main.complete {
                        Image(systemName: "checkmark.square")
                            .font(.system(size: 25, weight: .light))
                            .foregroundColor(Color.init(UIColor.label))
                    } else {
                        Image(systemName: "square")
                            .font(.system(size: 25, weight: .light))
                            .foregroundColor(Color.init(UIColor.label))
                    }
                }
            } else {
                Image(systemName: "square")
                    .font(.system(size: 25, weight: .light))
                    .foregroundColor(Color.init(UIColor.label))
            }
            Spacer()
            if deleted {
                Text("deleting...")
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.label))
            } else if !editing {
                Text(globalVars.dailyTasks[taskIndex].main.text)
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.label))
                    .onTapGesture(count: 2) {
                        self.editing = true
                    }
                    .onLongPressGesture {
                        self.confirmingDelete = true
                    }
                    .onTapGesture(count: 1) {
                        self.viewingNotes = true
                    }
                    .sheet(isPresented: $viewingNotes, content: {
                        taskNotes(taskIndex: self.taskIndex)
                            .environmentObject(self.globalVars)
                    })
            } else {
                TextField("edit task", text: $globalVars.dailyTasks[self.taskIndex].main.text) {
                    self.editing = false
                }
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
            }
            Spacer()
            if !deleted {
                if globalVars.dailyTasks[taskIndex].main.priority == 1 {
                    Text("  !  ")
                        .font(.system(size: 10, weight: .light))
                } else if globalVars.dailyTasks[taskIndex].main.priority == 2 {
                    Text(" ! ! ")
                        .font(.system(size: 10, weight: .light))
                } else if globalVars.dailyTasks[taskIndex].main.priority == 3 {
                    Text("! ! !")
                        .font(.system(size: 10, weight: .light))
                } else {
                    Text("     ")
                        .font(.system(size: 10, weight: .light))
                }
            } else {
                Text("     ")
                    .font(.system(size: 10, weight: .light))
            }
        }
            .padding(.horizontal, 25)
            .alert(isPresented: $confirmingDelete) {
                Alert(
                    title: Text("confirm delete"),
                    message: Text("the task will be gone forever, with no option to restore"),
                    primaryButton: .destructive(Text("delete")) {
                        self.globalVars.dailyTasks.remove(at: self.taskIndex)
                        self.deleted = true
                    },
                    secondaryButton: .cancel(Text("cancel"))
                )
            }
    }
}
