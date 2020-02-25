//
//  ContentView.swift
//  txtodo
//
//  Created by FIGBERT on 2/15/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import SwiftUI

struct IntroView: View {
    @EnvironmentObject var globalVars: GlobalVars
    var body: some View {
        VStack {
            Text("txtodo")
                .font(.system(size: 125, weight: .ultraLight, design: .rounded))
            Button(action: {
                self.globalVars.currentPage = "home"
            }) {
                Image(systemName: "arrow.right.circle")
                    .font(.system(size: 125, weight: .ultraLight, design: .rounded))
                    .foregroundColor(Color.init(UIColor.label))
            }
        }
    }
}

struct HomeView: View {
    @EnvironmentObject var globalVars: GlobalVars
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    VStack {
                        Text("floating")
                            .font(.system(size: 25, weight: .medium, design: .rounded))
                            .underline()
                        ForEach(self.globalVars.floatingTasks, id: \.self) {
                            superTaskView(task_: $0)
                        }
                    }.padding(.bottom, 45)
                    VStack {
                        Text("today")
                            .font(.system(size: 25, weight: .medium, design: .rounded))
                            .underline()
                        ForEach(self.globalVars.dailyTasks, id: \.self) {
                            noteTaskView(task_: $0)
                        }
                    }
                    Spacer()
                }
            }
                .background(Color.init(UIColor.systemGray6)
                .edgesIgnoringSafeArea(.all))
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var viewRouter: GlobalVars
    var body: some View {
        ZStack {
            Color.init(UIColor.systemGray6)
                .edgesIgnoringSafeArea(.all)
            if viewRouter.currentPage == "intro" {
                IntroView()
            } else if viewRouter.currentPage == "home" {
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalVars())
    }
}
