//
//  SalikProjectApp.swift
//  SalikProject
//


import SwiftUI

@main
struct SalikProjectApp: App {

    @StateObject var user = UserModel()
    @StateObject var appState = AppState()
    @StateObject var reportService = ReportService()

    var body: some Scene {
        WindowGroup {

            NavigationStack {
                if appState.isLoggedIn {
                    MainTabView()
                        .environmentObject(user)
                        .environmentObject(appState)
                        .environmentObject(reportService)
                } else {
                    LoginView()
                        .environmentObject(user)
                        .environmentObject(appState)
                        .environmentObject(reportService)
                }
            }

        }
    }
}
