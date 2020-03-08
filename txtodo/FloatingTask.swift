//
//  FloatingTask.swift
//  txtodo
//
//  Created by FIGBERT on 2/28/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import Foundation
import SwiftUI

struct superTaskView: View {
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
                    self.globalVars.floatingTasks[self.taskIndex].main.complete.toggle()
                }) {
                    if globalVars.floatingTasks[taskIndex].main.complete {
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
                Text(globalVars.floatingTasks[taskIndex].main.text)
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
                        taskSubtasks(taskIndex: self.taskIndex)
                            .environmentObject(self.globalVars)
                    })
            } else {
                TextField("edit task", text: $globalVars.floatingTasks[self.taskIndex].main.text) {
                    self.editing = false
                }
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .multilineTextAlignment(.center)
            }
            Spacer()
            if !deleted {
                if globalVars.floatingTasks[taskIndex].main.priority == 1 {
                    Text("  !  ")
                        .font(.system(size: 10, weight: .light))
                } else if globalVars.floatingTasks[taskIndex].main.priority == 2 {
                    Text(" ! ! ")
                        .font(.system(size: 10, weight: .light))
                } else if globalVars.floatingTasks[taskIndex].main.priority == 3 {
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
                        self.globalVars.floatingTasks.remove(at: self.taskIndex)
                        self.deleted = true
                    },
                    secondaryButton: .cancel(Text("cancel"))
                )
            }
    }
}

struct subTaskView: View {
    @EnvironmentObject var globalVars: GlobalVars
    @State var editing: Bool = false
    @State var viewingNotes: Bool = false
    @State var confirmingDelete: Bool = false
    @State var deleted: Bool = false
    let superIndex: Int
    let subIndex: Int
    var body: some View {
        HStack {
            if !deleted {
                Button(action: {
                    self.globalVars.floatingTasks[self.superIndex].subTasks[self.subIndex].main.complete.toggle()
                }) {
                    if globalVars.floatingTasks[superIndex].subTasks[subIndex].main.complete {
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
                Text(globalVars.floatingTasks[self.superIndex].subTasks[subIndex].main.text)
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
                        print("here")
                    }
                    .sheet(isPresented: $viewingNotes, content: {
                        subTaskNotes(superIndex: self.superIndex, subIndex: self.subIndex)
                            .environmentObject(self.globalVars)
                    })
            } else {
                TextField("edit task", text: $globalVars.floatingTasks[self.superIndex].subTasks[self.subIndex].main.text) {
                    self.editing = false
                }
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .multilineTextAlignment(.center)
            }
            Spacer()
            if !deleted {
                if globalVars.floatingTasks[self.superIndex].subTasks[subIndex].main.priority == 1 {
                    Text("  !  ")
                        .font(.system(size: 10, weight: .light))
                } else if globalVars.floatingTasks[self.superIndex].subTasks[subIndex].main.priority == 2 {
                    Text(" ! ! ")
                        .font(.system(size: 10, weight: .light))
                } else if globalVars.floatingTasks[self.superIndex].subTasks[subIndex].main.priority == 3 {
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
                        self.globalVars.floatingTasks[self.superIndex].subTasks.remove(at: self.subIndex)
                        self.deleted = true
                    },
                    secondaryButton: .cancel(Text("cancel"))
                )
            }
    }
}

struct taskSubtasks: View {
    @EnvironmentObject var globalVars: GlobalVars
    let taskIndex: Int
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text(globalVars.floatingTasks[taskIndex].main.text)
                    .font(.system(size: 25, weight: .medium, design: .rounded))
                    .underline()
                ForEach(globalVars.floatingTasks[taskIndex].subTasks.indices, id: \.self) { index in
                    subTaskView(superIndex: self.taskIndex, subIndex: index)
                }
                addSubTask(superIndex: taskIndex)
            }
                .padding(.top, 25)
        }
        .navigationBarTitle(Text(globalVars.floatingTasks[taskIndex].main.text), displayMode: .inline)
        .background(Color.init(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
    }
}
