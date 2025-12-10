//
//  SalikProjectApp.swift
//  SalikProject


import SwiftUI

@main
struct SalikProjectApp: App {

    // المخزن الوحيد للتقارير في التطبيق
    @StateObject private var reportStore = ReportStore()
    @StateObject private var userModel = UserModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LoginView(reportStore: reportStore)
            }
            .environmentObject(reportStore)
            .environmentObject(userModel)
        }
    }
}
