//
//  ContentView.swift
//  txtodo
//
//  Created by FIGBERT on 2/15/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: NoteTask.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \NoteTask.completed, ascending: false),
            NSSortDescriptor(keyPath: \NoteTask.priority, ascending: false)
        ]
    ) var dailyTasks: FetchedResults<NoteTask>
    let currentDay = Calendar.current.component(.day, from: Date.init())
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text("today")
                    .font(.system(size: 25, weight: .medium, design: .rounded))
                    .underline()
                ForEach(self.dailyTasks, id: \.id) { task in
                    Group {
                        if Calendar.current.component(.day, from: task.creationDate) == self.currentDay {
                            dailyTaskView(
                                task: task,
                                completed: task.completed,
                                name: task.name,
                                priority: Int(task.priority)
                            )
                                .environment(\.managedObjectContext, self.managedObjectContext)
                        } else {
                            EmptyView().onAppear(perform: {
                                self.managedObjectContext.performAndWait {
                                    self.managedObjectContext.delete(task)
                                    try? self.managedObjectContext.save()
                                }
                            })
                        }
                    }
                }
                addTask().environment(\.managedObjectContext, self.managedObjectContext)
            }
                .padding(.top, 45)
            Spacer()
        }
            .background(Color.init(UIColor.systemGray6)
            .edgesIgnoringSafeArea(.all))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
