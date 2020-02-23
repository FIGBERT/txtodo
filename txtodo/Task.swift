//
//  Elements.swift
//  txtodo
//
//  Created by Benjamin Welner on 2/17/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import Foundation
import SwiftUI

struct task: Codable, Hashable {
    var complete: Bool = false
    var text: String
    var priority: Int!
}

struct noteTask: Codable, Hashable {
    var main: task
    var notes: [String]!
}

struct superTask: Codable, Hashable {
    var main: task
    var subTasks: [noteTask]!
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

struct noteTaskView: View {
    @State var task_: noteTask
    let calendar = Calendar.current
    var body: some View {
        HStack {
            Button(action: {
                self.task_.main.complete.toggle()
            }) {
                if task_.main.complete {
                    Image(systemName: "checkmark.square")
                } else {
                    Image(systemName: "square")
                }
            }
                .font(.system(size: 25, weight: .light))
                .foregroundColor(Color.init(UIColor.label))
            Spacer()
            NavigationLink(destination: taskNotes(task_: task_)) {
                Text(task_.main.text)
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.label))
            }
            Spacer()
            if task_.main.priority == 1 {
                Text("  !  ")
                    .font(.system(size: 10, weight: .light))
            } else if task_.main.priority == 2 {
                Text(" ! ! ")
                    .font(.system(size: 10, weight: .light))
            } else if task_.main.priority == 3 {
                Text("! ! !")
                    .font(.system(size: 10, weight: .light))
            }
        }.padding(.horizontal, 25)
    }
}

struct superTaskView: View {
    @State var task_: superTask
    var body: some View {
        HStack {
            Button(action: {
                self.task_.main.complete.toggle()
            }) {
                if task_.main.complete {
                    Image(systemName: "checkmark.square")
                } else {
                    Image(systemName: "square")
                }
            }
                .font(.system(size: 25, weight: .light))
                .foregroundColor(Color.init(UIColor.label))
            Spacer()
            NavigationLink(destination: taskSubtasks(task_: task_)) {
                Text(task_.main.text)
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.label))
            }
            Spacer()
            VStack {
                if task_.main.priority == 1 {
                    Text("  !  ")
                        .font(.system(size: 10, weight: .light))
                } else if task_.main.priority == 2 {
                    Text(" ! ! ")
                        .font(.system(size: 10, weight: .light))
                } else if task_.main.priority == 3 {
                    Text("! ! !")
                        .font(.system(size: 10, weight: .light))
                }
            }
        }.padding(.horizontal, 25)
    }
}

struct taskNotes: View {
    @State var task_: noteTask
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(task_.notes, id: \.self) {
                    taskNote(note: $0)
                }
            }
                .padding(.top, 25)
        }
        .navigationBarTitle(Text(task_.main.text), displayMode: .inline)
        .background(Color.init(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
    }
}

struct taskSubtasks: View {
    @State var task_: superTask
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(task_.subTasks, id: \.self) {
                    noteTaskView(task_: $0)
                }
            }
                .padding(.top, 25)
        }
        .navigationBarTitle(Text(task_.main.text), displayMode: .inline)
        .background(Color.init(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
    }
}
