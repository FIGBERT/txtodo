//
//  AddItem.swift
//  txtodo
//
//  Created by FIGBERT on 2/28/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import Foundation
import SwiftUI

struct addTask: View {
    @EnvironmentObject var globalVars: GlobalVars
    @State var addingTask: Bool = false
    @State var newTaskText: String = ""
    @State var newTaskPriority: Int = 0
    let createType: String
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
                        if self.newTaskText != "" {
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
                        }
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
    @State var addingTask: Bool = false
    @State var newTaskText: String = ""
    @State var newTaskPriority: Int = 0
    let superIndex: Int
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
                        if self.newTaskText != "" {
                            self.globalVars.floatingTasks[self.superIndex].subTasks.append(
                                noteTask(
                                    main: task(
                                        text: self.newTaskText,
                                        priority: self.newTaskPriority
                                    )
                                )
                            )
                            self.newTaskText = ""
                        }
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
    @State var addingNote: Bool = false
    @State var newNoteText: String = ""
    let taskIndex: Int
    var body: some View {
        Group {
            if !addingNote {
                Button(action: {
                    self.addingNote = true
                }) {
                    HStack {
                        Image(systemName: "plus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Text("create a note")
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
                        if self.newNoteText != "" {
                            self.globalVars.dailyTasks[self.taskIndex].notes.append(self.newNoteText)
                            self.newNoteText = ""
                        }
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
    @State var addingNote: Bool = false
    @State var newNoteText: String = ""
    let superIndex: Int
    let subIndex: Int
    var body: some View {
        Group {
            if !addingNote {
                Button(action: {
                    self.addingNote = true
                }) {
                    HStack {
                        Image(systemName: "plus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Text("create a note")
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
                        if self.newNoteText != "" {
                            self.globalVars.floatingTasks[self.superIndex].subTasks[self.subIndex].notes.append(self.newNoteText)
                            self.newNoteText = ""
                        }
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
