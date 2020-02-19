//
//  ContentView.swift
//  txtodo
//
//  Created by FIGBERT on 2/15/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import SwiftUI

struct IntroView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack {
            Text("txtodo")
                .font(.system(size: 125, weight: .ultraLight, design: .rounded))
            Button(action: {
                self.viewRouter.currentPage = "home"
            }) {
                Image(systemName: "arrow.right.circle")
                    .font(.system(size: 125, weight: .ultraLight, design: .rounded))
                    .foregroundColor(Color.init(UIColor.label))
            }
        }
    }
}

struct HomeView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack {
            Group {
                Text("floating")
                    .font(.system(size: 25, weight: .medium, design: .rounded))
                    .underline()
                taskView(task_: task(complete: false, text: "Complete txtodo", time: Date()))
            }
            Group {
                Text("today")
                    .font(.system(size: 25, weight: .medium, design: .rounded))
                    .underline()
                taskView(task_: task(complete: true, text: "hello", time: Date(), priority: 3))
                taskView(task_: task(complete: false, text: "world", time: Date(), priority: 2))
            }
            Spacer()
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var viewRouter: ViewRouter
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
        ContentView().environmentObject(ViewRouter())
    }
}
