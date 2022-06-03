//
//  Styles.swift
//  txtodo
//
//  Created by FIGBERT on 3/22/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import SwiftUI

struct MainText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .light, design: .rounded))
            .foregroundColor(Color.init(UIColor.label))
            .multilineTextAlignment(.center)
    }
}

struct MainNote: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .light, design: .rounded))
            .foregroundColor(Color.init(UIColor.label))
            .multilineTextAlignment(.leading)
    }
}

struct MainImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25, weight: .light))
            .foregroundColor(Color.init(UIColor.label))
    }
}

struct SmallText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .light))
            .foregroundColor(Color.init(UIColor.systemGray))
            .multilineTextAlignment(.center)
    }
}

struct Annotation: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12, weight: .light))
            .foregroundColor(Color.init(UIColor.systemGray))
    }
}

struct SmallImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .light))
            .foregroundColor(Color.init(UIColor.systemGray))
    }
}

struct Header: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25, weight: .medium, design: .rounded))
            .foregroundColor(Color.init(UIColor.label))
            .multilineTextAlignment(.center)
    }
}

extension View {
    func mainTextStyle() -> some View {
        self.modifier(MainText())
    }
    func mainNoteStyle() -> some View {
        self.modifier(MainNote())
    }
    func mainImageStyle() -> some View {
        self.modifier(MainImage())
    }
    func smallTextStyle() -> some View {
        self.modifier(SmallText())
    }
    func annotateStyle() -> some View {
        self.modifier(Annotation())
    }
    func smallImageStyle() -> some View {
        self.modifier(SmallImage())
    }
    func headerStyle() -> some View {
        self.modifier(Header())
    }
}
