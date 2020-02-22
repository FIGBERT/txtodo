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
        NavigationView {
            VStack {
                VStack {
                    Text("floating")
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                        .underline()
                    taskView(task_: task(complete: false, text: "Complete txtodo", time: Date()))
                }.padding(.bottom, 45)
                VStack {
                    Text("today")
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                        .underline()
                    taskView(task_: task(complete: true, text: "hello", time: Date(), notes: ["Lorem ipsum dolor sit amet", "consectetur adipiscing elit", "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", "Ut enim ad minim veniam", "quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat", "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur", "Excepteur sint occaecat cupidatat non proident", "sunt in culpa qui officia deserunt mollit anim id est laborum"]))
                    taskView(task_: task(complete: false, text: "world", time: Date(), notes: ["Lorem ipsum dolor sit amet", "consectetur adipiscing elit", "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", "Tempor orci dapibus ultrices in iaculis nunc sed augue", "Dictum at tempor commodo ullamcorper a", "Consectetur libero id faucibus nisl tincidunt eget nullam non nisi", "Urna id volutpat lacus laoreet non", "Arcu odio ut sem nulla pharetra diam sit", "Odio aenean sed adipiscing diam", "Purus sit amet volutpat consequat mauris nunc congue nisi"]))
                }
                Spacer()
            }
            .background(Color.init(UIColor.systemGray6)
            .edgesIgnoringSafeArea(.all))
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
