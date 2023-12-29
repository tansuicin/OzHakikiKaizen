//
//  KaizenApp.swift
//  Kaizen
//
//  Created by Tansu ICIN on 16.12.2023.
//

import SwiftUI

@main
struct KaizenApp: App {
    @StateObject private var store = CategoryStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView(categories: $store.categories) {
                Task {
                    do {
                        try await store.save(categories: store.categories)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
