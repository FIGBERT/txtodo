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
