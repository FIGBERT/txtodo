//
//  TaskNote.swift
//  txtodo
//
//  Created by FIGBERT on 2/28/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import Foundation
import SwiftUI

struct dailyTaskNote: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var task: NoteTask
    @State var notes: [String]
    @State var note: String
    @State var index: Int
    @State private var editing: Bool = false
    @State private var confirmingDelete: Bool = false
    @State private var removed: Bool = false
    var body: some View {
        HStack {
            MainImage(name: "minus", color: .label)
                .padding(.trailing, 20)
            if removed {
                BodyText(text: "deleting...", color: .label, alignment: .leading, strikethrough: false)
            } else if !editing {
                BodyText(text: note, color: .label, alignment: .leading, strikethrough: false)
                    .onTapGesture(count: 2) {
                        self.editing = true
                    }
                    .onLongPressGesture {
                        self.confirmingDelete = true
                    }
            } else {
                EditingField(placeholder: "editing note", text: $note, alignment: .leading, onEnd: {
                    self.editing = false
                    self.managedObjectContext.performAndWait {
                        self.task.notes[self.index] = self.note
                        try? self.managedObjectContext.save()
                    }
                })
            }
            Spacer()
        }
            .padding(.horizontal, 25)
            .alert(isPresented: $confirmingDelete) {
                Alert(
                    title: Text("confirm delete"),
                    message: Text("\"\(note)\" will be gone forever, with no option to restore"),
                    primaryButton: .destructive(Text("delete")) {
                        self.managedObjectContext.performAndWait {
                            self.task.notes.remove(at: self.index)
                            try? self.managedObjectContext.save()
                        }
                        self.removed = true
                    },
                    secondaryButton: .cancel(Text("cancel"))
                )
            }
    }
}

struct taskNotes: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var task: NoteTask
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Header(text: task.name, underline: true)
                    .padding(.horizontal)
                ForEach(Array(task.notes.enumerated()), id: \.element) { index, note in
                    dailyTaskNote(
                        task: self.task,
                        notes: self.task.notes,
                        note: note,
                        index: index
                    )
                }
                addNote(
                    task: task
                )
            }
                .padding(.top, 25)
        }
        .background(Color.init(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
    }
}
