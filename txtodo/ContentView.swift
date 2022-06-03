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
        Group {
            if !globalVars.showOnboarding {
                HomeScreen().environmentObject(globalVars)
            } else {
                Onboarding().environmentObject(globalVars)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalVars())
    }
}
