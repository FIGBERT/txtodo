//
//  Styles.swift
//  txtodo
//
//  Created by FIGBERT on 3/22/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import SwiftUI

struct Header: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25, weight: .medium, design: .rounded))
            .foregroundColor(Color.init(UIColor.label))
            .multilineTextAlignment(.center)
    }
}

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

struct EditMain: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .light, design: .rounded))
            .foregroundColor(Color.init(UIColor.systemGray))
            .multilineTextAlignment(.center)
    }
}

struct EditNote: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .light, design: .rounded))
            .foregroundColor(Color.init(UIColor.systemGray))
            .multilineTextAlignment(.leading)
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

struct MainImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25, weight: .light))
            .foregroundColor(Color.init(UIColor.label))
    }
}

struct SmallImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .light))
            .foregroundColor(Color.init(UIColor.systemGray))
    }
}

extension View {
    func headerStyle() -> some View {
        self.modifier(Header())
    }
    func mainTextStyle() -> some View {
        self.modifier(MainText())
    }
    func mainNoteStyle() -> some View {
        self.modifier(MainNote())
    }
    func editMainTextStyle() -> some View {
        self.modifier(EditMain())
    }
    func editNoteStyle() -> some View {
        self.modifier(EditNote())
    }
    func smallTextStyle() -> some View {
        self.modifier(SmallText())
    }
    func annotateStyle() -> some View {
        self.modifier(Annotation())
    }
    func mainImageStyle() -> some View {
        self.modifier(MainImage())
    }
    func smallImageStyle() -> some View {
        self.modifier(SmallImage())
    }
}
