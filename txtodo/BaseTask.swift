//
//  BaseTask.swift
//  txtodo
//
//  Created by FIGBERT on 2/17/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import Foundation
import SwiftUI

struct task: Codable, Hashable {
    var complete: Bool = false
    var text: String
    var priority: Int = 0
}

struct noteTask: Codable, Hashable {
    var main: task
    var notes: [String] = []
}

struct superTask: Codable, Hashable {
    var main: task
    var subTasks: [noteTask] = []
}
