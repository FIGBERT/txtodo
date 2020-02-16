//
//  ContentView.swift
//  txtodo
//
//  Created by FIGBERT on 2/15/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        NavigationView {
            if viewRouter.currentPage == "intro" {
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
            } else if viewRouter.currentPage == "home" {
                Text("temp")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ViewRouter())
    }
}
