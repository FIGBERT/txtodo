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
    @Published var dailyTasks: [noteTask] = [
        noteTask(
            main: task(
                complete: true,
                text: "hello",
                priority: 3
            ),
            notes: [
                "Lorem ipsum dolor sit amet",
                "consectetur adipiscing elit",
                "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                "Ut enim ad minim veniam",
                "quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur",
                "Excepteur sint occaecat cupidatat non proident",
                "sunt in culpa qui officia deserunt mollit anim id est laborum"
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
                "consectetur adipiscing elit",
                "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                "Ut enim ad minim veniam",
                "quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur",
                "Excepteur sint occaecat cupidatat non proident",
                "sunt in culpa qui officia deserunt mollit anim id est laborum"
            ]
        )
    ]
}
