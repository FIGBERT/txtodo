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
            NSSortDescriptor(keyPath: \NoteTask.id, ascending: true)
        ]
    ) var dailyTasks: FetchedResults<NoteTask>
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text("today")
                    .font(.system(size: 25, weight: .medium, design: .rounded))
                    .underline()
                ForEach(Array(self.dailyTasks.enumerated()), id: \.element) { index, dailyTask in
                    dailyTaskView(
                        task: dailyTask,
                        name: dailyTask.name,
                        completed: dailyTask.completed,
                        taskIndex: index
                    )
                        .environment(\.managedObjectContext, self.managedObjectContext)
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
