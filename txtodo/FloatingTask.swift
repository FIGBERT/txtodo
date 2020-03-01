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
    @State var navigate: Bool = false
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
            if !editing {
                HStack(alignment: .top) {
                    Text(globalVars.floatingTasks[taskIndex].main.text)
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color.init(UIColor.label))
                    NavigationLink(destination: taskSubtasks(taskIndex: taskIndex), isActive: $navigate) {
                        EmptyView()
                    }
                }
                    .onTapGesture(count: 2) {
                        self.editing = true
                    }
                    .onTapGesture(count: 1) {
                        self.navigate = true
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
            } else {
                TextField("edit task", text: $globalVars.floatingTasks[self.taskIndex].main.text) {
                    self.editing = false
                }
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
            }
        }.padding(.horizontal, 25)
    }
}

struct subTaskView: View {
    @EnvironmentObject var globalVars: GlobalVars
    @State var editing: Bool = false
    @State var navigate: Bool = false
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
            if !editing {
                HStack(alignment: .top) {
                    Text(globalVars.floatingTasks[self.superIndex].subTasks[subIndex].main.text)
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color.init(UIColor.label))
                    NavigationLink(destination: subTaskNotes(superIndex: superIndex, subIndex: subIndex), isActive: $navigate) {
                        EmptyView()
                    }
                }
                    .onTapGesture(count: 2) {
                        self.editing = true
                    }
                    .onTapGesture(count: 1) {
                        self.navigate = true
                        print("here")
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
            } else {
                TextField("edit task", text: $globalVars.floatingTasks[self.superIndex].subTasks[self.subIndex].main.text) {
                    self.editing = false
                }
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
            }
        }.padding(.horizontal, 25)
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
