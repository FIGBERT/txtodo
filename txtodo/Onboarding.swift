//
//  Onboarding.swift
//  txtodo
//
//  Created by FIGBERT on 3/16/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import SwiftUI
import UserNotifications

class OnboardingRouter: ObservableObject {
    @Published var showOnboarding: Bool
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            showOnboarding = true
        } else {
            showOnboarding = false
        }
    }
}

struct Onboarding: View {
    @EnvironmentObject var onboarding: OnboardingRouter
    @State private var page: Int = 0
    @State private var offset: CGSize = .zero
    var body: some View {
        ZStack {
            Color.init(UIColor.systemGray6)
                .edgesIgnoringSafeArea(.all)
            VStack {
                if page == 0 {
                    Intro()
                } else if page == 1 {
                    RequestNotifications()
                } else if page == 2 {
                    AddTaskOverview()
                } else if page == 3 {
                    TaskOverview()
                } else if page == 4 {
                    Support()
                }
            }
                .animation(.interactiveSpring())
                .offset(x: offset.width)
                .gesture(
                    DragGesture()
                        .onChanged({ self.offset = $0.translation })
                        .onEnded({
                            if $0.translation.width < -100 {
                                if self.page != 4 {
                                    self.page += 1
                                } else {
                                    self.onboarding.showOnboarding = false
                                }
                            } else if $0.translation.width > 100 {
                                if self.page > 0 {
                                    self.page -= 1
                                }
                            }
                            self.offset = .zero
                        })
                )
        }
    }
}

struct Intro: View {
    var body: some View {
        VStack {
            Spacer()
            Text("txtodo")
                .font(.system(size: 125, weight: .ultraLight, design: .rounded))
                .foregroundColor(Color.init(UIColor.label))
            Text("a minimalist open-source todo app")
                .font(.system(size: 20, weight: .light))
                .foregroundColor(Color.init(UIColor.label))
            Text("made by FIGBERT")
                .font(.system(size: 20, weight: .light))
                .foregroundColor(Color.init(UIColor.systemGray))
            Spacer()
            Swipe()
        }
    }
}

struct RequestNotifications: View {
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                UNUserNotificationCenter.current().requestAuthorization(
                    options: [.alert, .badge, .sound]
                ) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }) {
                Text("allow notifications")
                    .font(.system(size: 25, weight: .medium))
                    .foregroundColor(Color.init(UIColor.label))
                    .padding()
            }
            Text("txtodo uses notifications to remind users to set the day's tasks in the morning")
                .font(.system(size: 20, weight: .light))
                .multilineTextAlignment(.center)
                .padding(25)
            Text("notifications are NOT REQUIRED. you can always change your mind in the application's settings menu")
                .font(.system(size: 15, weight: .light))
                .foregroundColor(Color.init(UIColor.systemGray))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 25)
            Spacer()
            Swipe()
        }
    }
}

struct AddTaskOverview: View {
    var body: some View {
        VStack {
            Spacer()
            Text("adding a task")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(Color.init(UIColor.label))
                .padding(35)
            AddTaskDemo()
            Spacer()
            Spacer()
            Swipe()
        }
    }
}

struct TaskOverview: View {
    var body: some View {
        VStack {
            Spacer()
            Text("changing a task")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(Color.init(UIColor.label))
                .padding(35)
            TaskDemo()
            Spacer()
            Spacer()
            Swipe()
        }
    }
}

struct Support: View {
    var body: some View {
        VStack {
            Spacer()
            Text("thanks for downloading")
                .font(.system(size: 35, weight: .ultraLight, design: .rounded))
                .foregroundColor(Color.init(UIColor.label))
            Text("more projects available on")
                .font(.system(size: 20, weight: .light))
                .foregroundColor(Color.init(UIColor.label))
            Text("figbert.com")
                .font(.system(size: 20, weight: .light))
                .foregroundColor(Color.init(UIColor.link))
                .onTapGesture {
                    guard let url = URL(string: "https://figbert.com") else { return }
                    UIApplication.shared.open(url)
                }
            Spacer()
            Swipe()
        }
    }
}

struct AddTaskDemo: View {
    @State var addingTask: Bool = false
    @State var text: String = ""
    @State var priority: Int = 0
    var body: some View {
        Group {
            if !addingTask {
                VStack {
                    VStack {
                        Text("tap once to begin creating a task")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Image(systemName: "arrow.down")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }
                    HStack {
                        Image(systemName: "plus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Text("create a task")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Image(systemName: "plus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }
                        .padding(.horizontal, 25)
                        .onTapGesture {
                            self.addingTask = true
                        }
                }
            } else {
                VStack {
                    HStack {
                        Text("tap to cancel")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Text("tap to edit text")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Text("tap to edit priority")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Text("tap to add")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }
                        .padding(.horizontal, 25)
                    HStack {
                        Image(systemName: "arrow.down")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Image(systemName: "arrow.down")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Image(systemName: "arrow.down")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Spacer()
                        Image(systemName: "arrow.down")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                    }
                        .padding(.horizontal, 25)
                    HStack {
                        Image(systemName: "multiply.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                            .onTapGesture {
                                self.text = ""
                                self.priority = 0
                                self.addingTask = false
                            }
                        Spacer()
                        TextField("tap here", text: $text)
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                            .multilineTextAlignment(.center)
                            .autocapitalization(.none)
                        Picker(
                            selection: $priority,
                            label: Text("task priority"),
                            content: {
                                Text("0").tag(0)
                                Text("1").tag(1)
                                Text("2").tag(2)
                                Text("3").tag(3)
                        })
                            .pickerStyle(SegmentedPickerStyle())
                        Spacer()
                        Image(systemName: "plus.square")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.init(UIColor.systemGray))
                            .onTapGesture {
                                self.text = ""
                                self.priority = 0
                                self.addingTask = false
                            }
                    }
                        .padding(.horizontal, 25)
                }
            }
        }
    }
}

struct TaskDemo: View {
    @State var complete: Bool = false
    @State var text: String = "lorem ipsum"
    @State var priority: Int = 3
    @State var editing: Bool = false
    let textOne: String = "single tap to open notes, double tap to edit, long press to confirm delete"
    let textTwo: String = "press return to confirm your changes"
    var body: some View {
        Group {
            HStack {
                Image(systemName: complete ? "checkmark.square" : "square")
                    .font(.system(size: 25, weight: .light))
                    .foregroundColor(Color.init(UIColor.label))
                    .onTapGesture {
                        self.complete.toggle()
                    }
                Spacer()
                if !editing {
                    Text(text)
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color.init(UIColor.label))
                        .multilineTextAlignment(.center)
                        .onTapGesture(count: 2) {
                            self.editing = true
                        }
                } else {
                    TextField("editing", text: $text) {
                        self.editing = false
                    }
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(Color.init(UIColor.systemGray))
                        .multilineTextAlignment(.center)
                }
                Spacer()
                if !editing {
                    if priority == 1 {
                        Text("  !  ")
                            .font(.system(size: 10, weight: .light))
                    } else if priority == 2 {
                        Text(" ! ! ")
                            .font(.system(size: 10, weight: .light))
                    } else if priority == 3 {
                        Text("! ! !")
                            .font(.system(size: 10, weight: .light))
                    } else {
                        Text("     ")
                            .font(.system(size: 10, weight: .light))
                    }
                } else {
                    Picker(
                        selection: $priority,
                        label: Text("task priority"),
                        content: {
                            Text("0").tag(0)
                            Text("1").tag(1)
                            Text("2").tag(2)
                            Text("3").tag(3)
                    })
                        .pickerStyle(SegmentedPickerStyle())
                }
            }
                .padding(.horizontal, 25)
            HStack {
                Image(systemName: "arrow.up")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(Color.init(UIColor.systemGray))
                Spacer()
                Image(systemName: "arrow.up")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(Color.init(UIColor.systemGray))
                Spacer()
                Image(systemName: "arrow.up")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(Color.init(UIColor.systemGray))
            }
                .padding(.horizontal, 30)
            HStack {
                Text("tap to toggle")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(Color.init(UIColor.systemGray))
                Spacer()
                Text(editing ? textTwo : textOne)
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .multilineTextAlignment(.center)
            }
                .padding(.horizontal, 15)
        }
    }
}

struct Swipe: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "hand.point.right")
            .font(.system(size: 15, weight: .light))
            .foregroundColor(Color.init(UIColor.systemGray))
            Text("swipe")
                .font(.system(size: 15, weight: .light))
                .foregroundColor(Color.init(UIColor.systemGray))
            Image(systemName: "hand.point.right")
                .font(.system(size: 15, weight: .light))
                .foregroundColor(Color.init(UIColor.systemGray))
            Spacer()
        }
            .padding()
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
