//
//  ViewRouter.swift
//  txtodo
//
//  Created by FIGBERT on 2/15/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import Foundation
import SwiftUI

class GlobalVars: ObservableObject {
    @Published var floatingTasks: [superTask] = []
    @Published var dailyTasks: [noteTask] = []
}
