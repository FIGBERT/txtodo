//
//  ContentView.swift
//  txtodo
//
//  Created by FIGBERT on 2/15/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("txtodo")
                .font(.system(size: 125, weight: .ultraLight, design: .rounded))
            Image(uiImage: UIImage(
                systemName: "arrow.right.circle",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 75,
                    weight: .ultraLight,
                    scale: .large
                )
            )!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
