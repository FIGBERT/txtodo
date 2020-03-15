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
    @Environment(\.managedObjectContext) var managedObjectContext
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
                    TextField("tap here", text: $newTaskText)
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color.init(UIColor.systemGray))
                        .multilineTextAlignment(.center)
                        .autocapitalization(.none)
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
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        guard self.newTaskText != "" else {return}
                        let newDailyTask = NoteTask(context: self.managedObjectContext)
                        newDailyTask.completed = false
                        newDailyTask.name = self.newTaskText
                        newDailyTask.priority = Int16(self.newTaskPriority)
                        newDailyTask.notes = [String]()
                        newDailyTask.id = UUID()
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error.localizedDescription)
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
                    TextField("tap here", text: $newTaskText)
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color.init(UIColor.systemGray))
                        .multilineTextAlignment(.center)
                        .autocapitalization(.none)
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
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var addingNote: Bool = false
    @State var newNoteText: String = ""
    @ObservedObject var task: NoteTask
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
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        self.newNoteText = ""
                        self.addingNote = false
                    }) {
                        Image(systemName: "multiply.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }
                    Spacer()
                    TextField("tap here", text: $newNoteText)
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color.init(UIColor.systemGray))
                        .multilineTextAlignment(.center)
                        .autocapitalization(.none)
                    Spacer()
                    Button(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        guard self.newNoteText != "" else {return}
                        self.managedObjectContext.performAndWait {
                            self.task.notes.append(self.newNoteText)
                            try? self.managedObjectContext.save()
                        }
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
                    TextField("tap here", text: $newNoteText)
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color.init(UIColor.systemGray))
                        .multilineTextAlignment(.center)
                        .autocapitalization(.none)
                    Spacer()
                    Button(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
