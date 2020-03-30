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
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var task: NoteTask
    @State var completed: Bool
    @State var name: String
    @State var priority: Int
    @State var editing: Bool = false
    @State var viewingNotes: Bool = false
    @State var confirmingDelete: Bool = false
    @State var deleted: Bool = false
    var body: some View {
        HStack {
            if !deleted {
                Button(action: {
                    self.completed.toggle()
                    self.managedObjectContext.performAndWait {
                        self.task.completed = self.completed
                        try? self.managedObjectContext.save()
                    }
                }) {
                    if task.completed {
                        Image(systemName: "checkmark.square")
                            .mainImageStyle()
                    } else {
                        Image(systemName: "square")
                            .mainImageStyle()
                    }
                }
            } else {
                Image(systemName: "square")
                    .mainImageStyle()
            }
            Spacer()
            if deleted {
                Text("deleting...")
                    .mainTextStyle()
            } else if !editing {
                Text(task.name)
                    .mainTextStyle()
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
                        taskNotes(task: self.task).environment(\.managedObjectContext, self.managedObjectContext)
                    })
            } else {
                TextField("edit task", text: $name) {
                    self.editing = false
                    self.managedObjectContext.performAndWait {
                        self.task.name = self.name
                        self.task.priority = Int16(self.priority)
                        try? self.managedObjectContext.save()
                    }
                }
                    .editMainTextStyle()
                    .autocapitalization(.none)
            }
            Spacer()
            if deleted {
                Text("     ")
                    .font(.system(size: 10, weight: .light))
            } else if !editing {
                if Int(task.priority) == 1 {
                    Text("  !  ")
                        .font(.system(size: 10, weight: .light))
                } else if Int(task.priority) == 2 {
                    Text(" ! ! ")
                        .font(.system(size: 10, weight: .light))
                } else {
                    Text("! ! !")
                        .font(.system(size: 10, weight: .light))
                }
            } else {
                Picker(
                    selection: $priority,
                    label: Text("task priority"),
                    content: {
                        Text("!").tag(1)
                        Text("!!").tag(2)
                        Text("!!!").tag(3)
                })
                    .pickerStyle(SegmentedPickerStyle())
            }
        }
            .padding(.horizontal, 25)
            .alert(isPresented: $confirmingDelete) {
                Alert(
                    title: Text("confirm delete"), 
                    message: Text("the task will be gone forever, with no option to restore"),
                    primaryButton: .destructive(Text("delete")) {
                        self.managedObjectContext.performAndWait {
                            self.managedObjectContext.delete(self.task)
                            try? self.managedObjectContext.save()
                        }
                    },
                    secondaryButton: .cancel(Text("cancel"))
                )
            }
    }
}
