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
                            .smallImageStyle()
                        Spacer()
                        Text("create a task")
                            .smallImageStyle()
                        Spacer()
                        Image(systemName: "plus.square")
                            .smallImageStyle()
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
                            .smallImageStyle()
                    }
                    Spacer()
                    TextField("tap here", text: $newTaskText)
                        .smallTextStyle()
                        .autocapitalization(.none)
                    Picker(
                        selection: $newTaskPriority,
                        label: Text("task priority"),
                        content: {
                            Text("!").tag(1)
                            Text("!!").tag(2)
                            Text("!!!").tag(3)
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
                        newDailyTask.creationDate = Date.init()
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
                            .smallImageStyle()
                        Spacer()
                        Text("create a note")
                            .smallImageStyle()
                        Spacer()
                        Image(systemName: "plus.square")
                            .smallImageStyle()
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
                            .smallImageStyle()
                    }
                    Spacer()
                    TextField("tap here", text: $newNoteText)
                        .smallTextStyle()
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
