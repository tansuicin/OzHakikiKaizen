//
//  VersionView.swift
//  Kaizen
//
//  Created by Tansu ICIN on 17.12.2023.
//

import SwiftUI

struct VersionView: View {
    var body: some View {
        NavigationStack{
            List {
                Section(header: Text("1.3.0")) {
                    Text("List items can be moved")
                }
                Section(header: Text("1.2.0")) {
                    Text("Notification feature added.")
                }
                Section(header: Text("1.1.0")) {
                    Text("Version info added.")
                }
                Section(header: Text("1.0.0")) {
                    Text("App published.")
                }
            }
            .navigationTitle("Version Info")
        }
    }
}

#Preview {
    VersionView()
}
