//
//  Elements.swift
//  txtodo
//
//  Created by FIGBERT on 2/17/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import Foundation
import SwiftUI

struct task: Codable, Hashable {
    var complete: Bool = false
    var text: String
    var priority: Int = 0
}

struct noteTask: Codable, Hashable {
    var main: task
    var notes: [String] = []
}

struct superTask: Codable, Hashable {
    var main: task
    var subTasks: [noteTask] = []
}

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

struct addTask: View {
    @EnvironmentObject var globalVars: GlobalVars
    let createType: String
    @State var addingTask: Bool = false
    @State var newTaskText: String = ""
    @State var newTaskPriority: Int = 0
    var body: some View {
        Group {
            if !addingTask {
                Button(action: {
                    self.addingTask = true
                }) {
                    HStack {
                        Image(systemName: "plus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Text("create a task")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Image(systemName: "plus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }.padding(.horizontal, 25)
                }
            } else {
                HStack {
                    Button(action: {
                        self.newTaskText = ""
                        self.newTaskPriority = 0
                        self.addingTask = false
                    }) {
                        Image(systemName: "multiply.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }
                    Spacer()
                    TextField("new task", text: $newTaskText)
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color.init(UIColor.systemGray))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                    Picker(
                        selection: $newTaskPriority,
                        label: Text("task priority"),
                        content: {
                            Text("0").tag(0)
                            Text("1").tag(1)
                            Text("2").tag(2)
                            Text("3").tag(3)
                    })
                        .pickerStyle(SegmentedPickerStyle())
                    Spacer()
                    Button(action: {
                        if self.createType == "daily" {
                            self.globalVars.dailyTasks.append(
                                noteTask(
                                    main: task(
                                        text: self.newTaskText,
                                        priority: self.newTaskPriority
                                    )
                                )
                            )
                        } else if self.createType == "floating" {
                            self.globalVars.floatingTasks.append(
                                superTask(
                                    main: task(
                                        text: self.newTaskText,
                                        priority: self.newTaskPriority
                                    )
                                )
                            )
                        }
                        self.newTaskText = ""
                        self.newTaskPriority = 0
                        self.addingTask = false
                    }) {
                        Image(systemName: "plus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }
                }.padding(.horizontal, 25)
            }
        }
    }
}

struct addSubTask: View {
    @EnvironmentObject var globalVars: GlobalVars
    let superIndex: Int
    @State var addingTask: Bool = false
    @State var newTaskText: String = ""
    @State var newTaskPriority: Int = 0
    var body: some View {
        Group {
            if !addingTask {
                Button(action: {
                    self.addingTask = true
                }) {
                    HStack {
                        Image(systemName: "plus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Text("create a task")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Image(systemName: "plus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }.padding(.horizontal, 25)
                }
            } else {
                HStack {
                    Button(action: {
                        self.newTaskText = ""
                        self.newTaskPriority = 0
                        self.addingTask = false
                    }) {
                        Image(systemName: "multiply.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }
                    Spacer()
                    TextField("new task", text: $newTaskText)
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color.init(UIColor.systemGray))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                    Picker(
                        selection: $newTaskPriority,
                        label: Text("task priority"),
                        content: {
                            Text("0").tag(0)
                            Text("1").tag(1)
                            Text("2").tag(2)
                            Text("3").tag(3)
                    })
                        .pickerStyle(SegmentedPickerStyle())
                    Spacer()
                    Button(action: {
                        self.globalVars.floatingTasks[self.superIndex].subTasks.append(
                            noteTask(
                                main: task(
                                    text: self.newTaskText,
                                    priority: self.newTaskPriority
                                )
                            )
                        )
                        self.newTaskText = ""
                        self.newTaskPriority = 0
                        self.addingTask = false
                    }) {
                        Image(systemName: "plus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }
                }.padding(.horizontal, 25)
            }
        }
    }
}

struct addNote: View {
    @EnvironmentObject var globalVars: GlobalVars
    let taskIndex: Int
    @State var addingNote: Bool = false
    @State var newNoteText: String = ""
    var body: some View {
        Group {
            if !addingNote {
                Button(action: {
                    self.addingNote = true
                }) {
                    HStack {
                        Image(systemName: "minus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Text("create a note")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Image(systemName: "minus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }.padding(.horizontal, 25)
                }
            } else {
                HStack {
                    Button(action: {
                        self.newNoteText = ""
                        self.addingNote = false
                    }) {
                        Image(systemName: "multiply.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }
                    Spacer()
                    TextField("new note", text: $newNoteText)
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color.init(UIColor.systemGray))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button(action: {
                        self.globalVars.dailyTasks[self.taskIndex].notes.append(self.newNoteText)
                        self.newNoteText = ""
                        self.addingNote = false
                    }) {
                        Image(systemName: "plus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }
                }.padding(.horizontal, 25)
            }
        }
    }
}

struct addSubNote: View {
    @EnvironmentObject var globalVars: GlobalVars
    let superIndex: Int
    let subIndex: Int
    @State var addingNote: Bool = false
    @State var newNoteText: String = ""
    var body: some View {
        Group {
            if !addingNote {
                Button(action: {
                    self.addingNote = true
                }) {
                    HStack {
                        Image(systemName: "minus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Text("create a note")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Image(systemName: "minus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }.padding(.horizontal, 25)
                }
            } else {
                HStack {
                    Button(action: {
                        self.newNoteText = ""
                        self.addingNote = false
                    }) {
                        Image(systemName: "multiply.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }
                    Spacer()
                    TextField("new note", text: $newNoteText)
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color.init(UIColor.systemGray))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button(action: {
                        self.globalVars.floatingTasks[self.superIndex].subTasks[self.subIndex].notes.append(self.newNoteText)
                        self.newNoteText = ""
                        self.addingNote = false
                    }) {
                        Image(systemName: "plus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }
                }.padding(.horizontal, 25)
            }
        }
    }
}

struct noteTaskView: View {
    @EnvironmentObject var globalVars: GlobalVars
    let taskIndex: Int
    let calendar = Calendar.current
    var body: some View {
        HStack {
            Button(action: {
                self.globalVars.dailyTasks[self.taskIndex].main.complete.toggle()
            }) {
                if globalVars.dailyTasks[taskIndex].main.complete {
                    Image(systemName: "checkmark.square")
                } else {
                    Image(systemName: "square")
                }
            }
                .font(.system(size: 25, weight: .light))
                .foregroundColor(Color.init(UIColor.label))
            Spacer()
            NavigationLink(destination: taskNotes(taskIndex: taskIndex)) {
                Text(globalVars.dailyTasks[taskIndex].main.text)
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.label))
            }
            Spacer()
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
        }.padding(.horizontal, 25)
    }
}

struct subTaskView: View {
    @EnvironmentObject var globalVars: GlobalVars
    let superIndex: Int
    let subIndex: Int
    var body: some View {
        HStack {
            Button(action: {
                self.globalVars.floatingTasks[self.superIndex].subTasks[self.subIndex].main.complete.toggle()
            }) {
                if globalVars.floatingTasks[superIndex].subTasks[subIndex].main.complete {
                    Image(systemName: "checkmark.square")
                } else {
                    Image(systemName: "square")
                }
            }
                .font(.system(size: 25, weight: .light))
                .foregroundColor(Color.init(UIColor.label))
            Spacer()
            NavigationLink(destination: subTaskNotes(superIndex: superIndex, subIndex: subIndex)) {
                Text(globalVars.floatingTasks[self.superIndex].subTasks[subIndex].main.text)
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.label))
            }
            Spacer()
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
        }.padding(.horizontal, 25)
    }
}

struct superTaskView: View {
    @EnvironmentObject var globalVars: GlobalVars
    let taskIndex: Int
    var body: some View {
        HStack {
            Button(action: {
                self.globalVars.floatingTasks[self.taskIndex].main.complete.toggle()
            }) {
                if globalVars.floatingTasks[taskIndex].main.complete {
                    Image(systemName: "checkmark.square")
                } else {
                    Image(systemName: "square")
                }
            }
                .font(.system(size: 25, weight: .light))
                .foregroundColor(Color.init(UIColor.label))
            Spacer()
            NavigationLink(destination: taskSubtasks(taskIndex: taskIndex)) {
                Text(globalVars.floatingTasks[taskIndex].main.text)
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.label))
            }
            Spacer()
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


struct taskSubtasks: View {
    @EnvironmentObject var globalVars: GlobalVars
    let taskIndex: Int
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
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
