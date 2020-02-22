//
//  Elements.swift
//  txtodo
//
//  Created by Benjamin Welner on 2/17/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import Foundation
import SwiftUI

struct task: Codable {
    var complete: Bool = false
    var text: String
    var time: Date!
    var priority: Int!
    var notes: [String]!
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

struct taskView: View {
    @State var task_: task
    let calendar = Calendar.current
    var body: some View {
        HStack {
            Button(action: {
                self.task_.complete.toggle()
            }) {
                if task_.complete {
                    Image(systemName: "checkmark.square")
                } else {
                    Image(systemName: "square")
                }
            }
                .font(.system(size: 25, weight: .light))
                .foregroundColor(Color.init(UIColor.label))
            Spacer()
            NavigationLink(destination: taskDetails(task_: task_)) {
                Text(task_.text)
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.init(UIColor.label))
            }
            Spacer()
            VStack {
                Text("\(calendar.component(.hour, from: task_.time)):\(calendar.component(.minute, from: task_.time))")
                    .font(.system(size: 10, weight: .light))
                if task_.priority == 1 {
                    Text("!")
                        .font(.system(size: 10, weight: .light))
                } else if task_.priority == 2 {
                    Text("! !")
                        .font(.system(size: 10, weight: .light))
                } else if task_.priority == 3 {
                    Text("! ! !")
                        .font(.system(size: 10, weight: .light))
                }
            }
        }.padding(.horizontal, 25)
    }
}

struct taskDetails: View {
    @State var task_: task
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(task_.notes, id: \.self) {
                    taskNote(note: $0)
                }
            }
                .padding(.top, 25)
        }
            .navigationBarTitle(Text(task_.text), displayMode: .inline)
            .background(Color.init(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
    }
}
