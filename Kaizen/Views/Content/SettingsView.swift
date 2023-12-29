//
//  SettingsView.swift
//  Kaizen
//
//  Created by Tansu ICIN on 16.12.2023.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    @State private var kNotification = UserDefaults.standard.bool(forKey: "KNotification")
    @Binding var categories: [Category]
    @State private var nCount: Int = 0
    
    var body: some View {
        NavigationStack{
            List {
                Section(header: Text("General")) {
                    Toggle(isOn: $kNotification) {
                        Text("Notifications")
                    }
                    .onChange(of: kNotification) {
                        if kNotification {
                            for language in $categories {
                                 nCount += language.notes.count
                            }
                            
                            SetLocalNotification(count: nCount)
                            UserDefaults.standard.set(true, forKey: "KNotification")
                           
                        }else{
                            UnsetLocalNotification()
                            UserDefaults.standard.removeObject(forKey: "KNotification")
                        }
                    }
                }
                Section(header: Text("Data")) {
                    Label("Import Data", systemImage: "square.and.arrow.down")
                    Label("Export Data", systemImage: "square.and.arrow.up")
                    Label("Delete All Data", systemImage: "trash").foregroundColor(.red)
                }
                Section(header: Text("About")) {
                    NavigationLink(destination: VersionView()) {
                        Label("Version Info", systemImage: "doc.badge.clock")
//                        HStack {
//                            Text("Version")
//                                .font(.subheadline)
//                            
//                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

func SetLocalNotification(count: Int){
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
        success, error in
        if success{
            let content = UNMutableNotificationContent()
            content.title = "Kaizen App"
            content.subtitle = "Alert"
            content.body = "You've \(count) notes"
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 10
            dateComponents.minute = 0
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
            
        }else if let error = error{
            print(error.localizedDescription)
        }
    }
}

func UnsetLocalNotification(){
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().removeAllDeliveredNotifications()
}


#Preview {
    SettingsView(categories: .constant(Category.sampleData))
}
