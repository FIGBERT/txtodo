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
    var time: Date
    var priority: Int
}

struct taskView: View {
    let task_: task
    let calendar = Calendar.current
    var body: some View {
        HStack {
            if task_.complete {
                Image(systemName: "checkmark.square")
                    .font(.system(size: 25, weight: .light))
            } else {
                Image(systemName: "square")
                    .font(.system(size: 25, weight: .light))
            }
            Spacer()
            Text(task_.text)
            Spacer()
            VStack {
                Text("\(calendar.component(.hour, from: task_.time)):\(calendar.component(.minute, from: task_.time))")
                    .font(.system(size: 10, weight: .light))
                if task_.priority < 0 {
                    Text("!")
                        .font(.system(size: 10, weight: .light))
                } else if task_.priority == 0 {
                    Text("! !")
                        .font(.system(size: 10, weight: .light))
                } else if task_.priority > 0 {
                    Text("! ! !")
                        .font(.system(size: 10, weight: .light))
                }
            }
        }
    }
}

struct taskView_Previews: PreviewProvider {
    static var previews: some View {
        taskView(task_: task(text: "task", time: Date(), priority: 1))
    }
}
