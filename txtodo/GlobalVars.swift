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
    @Published var currentPage: String = "intro"
    @Published var floatingTasks: [superTask] = [
        superTask(
            main: task(
                complete: false,
                text: "Complete txtodo",
                priority: 2
            ),
            subTasks: [
                noteTask(
                    main: task(
                        complete: true,
                        text: "hello",
                        priority: 3
                    ),
                    notes: [
                        "Lorem ipsum dolor sit amet",
                        "consectetur adipiscing elit"
                    ]
                ),
                noteTask(
                    main: task(
                        complete: false,
                        text: "world",
                        priority: 1
                    ),
                    notes: [
                        "Lorem ipsum dolor sit amet",
                        "consectetur adipiscing elit"
                    ]
                )
            ]
        )
    ]
    @Published var dailyTasks: [noteTask] = []
}
