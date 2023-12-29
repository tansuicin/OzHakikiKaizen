//
//  ContentView.swift
//  Kaizen
//
//  Created by Tansu ICIN on 16.12.2023.
//

import SwiftUI

struct ContentView: View {
    @Binding var categories: [Category]
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    @State private var selection: Tab = .categoriesview
    
    enum Tab{
        case categoriesview
        case settings
    }
    
    var body: some View {
        TabView (selection: $selection){
            CategoriesView(categories: $categories, saveAction:{})
                .tabItem{
                    Image(systemName: "house")
                }
            SettingsView(categories: $categories)
                .tabItem{
                    Image(systemName: "gearshape")
                }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .inactive { saveAction() }
        }
    }
}

#Preview {
    ContentView(categories: .constant(Category.sampleData), saveAction: {})
}
