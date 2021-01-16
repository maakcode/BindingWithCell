//
//  SwiftUIListView.swift
//  BindingWithCell
//
//  Created by Makeeyaf on 2021/01/15.
//

import SwiftUI
import Combine

struct SwiftUIListView: View {
    @State var data: [Setting] = [
        Setting(title: "Notification"),
        Setting(title: "DarkMode"),
        Setting(title: "Email Subscription"),
    ]

    var body: some View {
        List {
            ForEach(0..<data.count) { index in
                HStack {
                    Text("\(data[index].title)")
                    Toggle("", isOn: $data[index].isOn)
                }
            }
        }
    }
}
