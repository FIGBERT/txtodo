//
//  Styles.swift
//  txtodo
//
//  Created by FIGBERT on 3/22/20.
//  Copyright © 2020 FIGBERT Industries. All rights reserved.
//

import SwiftUI

struct Header: View {
    let text: String
    let underline: Bool
    var body: some View {
        Text(text)
            .underline(underline)
            .font(.system(size: 25, weight: .medium, design: .rounded))
            .foregroundColor(Color.init(UIColor.label))
            .multilineTextAlignment(.center)
    }
}

struct BodyText: View {
    let text: String
    let color: UIColor
    let alignment: TextAlignment
    let strikethrough: Bool
    var body: some View {
        Text(text)
            .font(.system(size: 20, weight: .light, design: .rounded))
            .strikethrough(strikethrough)
            .foregroundColor(Color.init(color))
            .multilineTextAlignment(alignment)
    }
}

struct EditingField: View {
    let placeholder: String
    var text: Binding<String>
    let alignment: TextAlignment
    let onEnd: () -> Void
    var body: some View {
        TextField(placeholder, text: text) {
            self.onEnd()
        }
            .font(.system(size: 20, weight: .light, design: .rounded))
            .foregroundColor(Color.init(UIColor.systemGray))
            .multilineTextAlignment(alignment)
            .autocapitalization(.none)
    }
}

struct MainImage: View {
    let name: String
    let color: UIColor
    var body: some View {
        Image(systemName: name)
            .font(.system(size: 25, weight: .light, design: .rounded))
            .foregroundColor(Color.init(color))
    }
}
