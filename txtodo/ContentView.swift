//
//  ContentView.swift
//  txtodo
//
//  Created by FIGBERT on 2/15/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var globalVars: GlobalVars
    var body: some View {
        ZStack {
            Color.init(UIColor.systemGray6)
                .edgesIgnoringSafeArea(.all)
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Text("floating")
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                        .underline()
                    ForEach(self.globalVars.floatingTasks.indices, id: \.self) { index in
                        superTaskView(taskIndex: index)
                    }
                    if globalVars.floatingTasks.count < 3 {
                        addTask(createType: "floating")
                    }
                }
                    .padding(.top, 60)
                    .padding(.bottom, 45)
                VStack {
                    Text("today")
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                        .underline()
                    ForEach(self.globalVars.dailyTasks.indices, id: \.self) { index in
                        dailyTaskView(taskIndex: index)
                    }
                    addTask(createType: "daily")
                }
                Spacer()
            }
                .background(Color.init(UIColor.systemGray6)
                .edgesIgnoringSafeArea(.all))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalVars())
    }
}
