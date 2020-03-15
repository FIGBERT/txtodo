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
    @State var name: String
    @State var completed: Bool
    @State var editing: Bool = false
    @State var viewingNotes: Bool = false
    @State var confirmingDelete: Bool = false
    @State var deleted: Bool = false
    let taskIndex: Int
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
                    .multilineTextAlignment(.center)
            } else if !editing {
                Text(task.name)
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.label))
                    .multilineTextAlignment(.center)
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
                        try? self.managedObjectContext.save()
                    }
                }
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .multilineTextAlignment(.center)
                    .autocapitalization(.none)
            }
            Spacer()
            if !deleted {
                if Int(task.priority) == 1 {
                    Text("  !  ")
                        .font(.system(size: 10, weight: .light))
                } else if Int(task.priority) == 2 {
                    Text(" ! ! ")
                        .font(.system(size: 10, weight: .light))
                } else if Int(task.priority) == 3 {
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
                        self.managedObjectContext.delete(self.task)
                    },
                    secondaryButton: .cancel(Text("cancel"))
                )
            }
    }
}
