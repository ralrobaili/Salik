//
//  MainTabView.swift
//  SalikProject
//
//  Created by raghad alenezi on 16/06/1447 AH.

//  MainTabView.swift

import SwiftUI

struct MainTabView: View {

    @EnvironmentObject var user: UserModel
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var reportService: ReportService

    var body: some View {
        VStack(spacing: 0) {

            ZStack {
                switch appState.selectedTab {
                case 0:
                    HomePageView()
                        .environmentObject(user)

                case 1:
                    CaptureInstructionsView()

                case 2:
                    ReportsContentView()
                        .environmentObject(reportService)

                case 3:
                    AccountView()
                        .environmentObject(user)
                        .environmentObject(appState)

                default:
                    HomePageView()
                        .environmentObject(user)
                }
            }

            HStack(spacing: 0) {

                TabButton(
                    index: 3,
                    selectedTab: $appState.selectedTab,
                    icon: "person.fill",
                    title: "حسابي"
                )

                Spacer()

                TabButton(
                    index: 2,
                    selectedTab: $appState.selectedTab,
                    icon: "doc.text",
                    title: "التقارير"
                )

                Spacer()

                TabButton(
                    index: 1,
                    selectedTab: $appState.selectedTab,
                    icon: "camera.fill",
                    title: "حادث جديد",
                    highlight: true
                )

                Spacer()

                TabButton(
                    index: 0,
                    selectedTab: $appState.selectedTab,
                    icon: "house.fill",
                    title: "الرئيسية"
                )
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white)
            .cornerRadius(22)
            .shadow(color: .black.opacity(0.07), radius: 8, y: -3)
        }
        .ignoresSafeArea(.keyboard)
    }
}

   struct TabButton: View {
    let index: Int
    @Binding var selectedTab: Int
    let icon: String
    let title: String
    var highlight: Bool = false

    var body: some View {
        Button {
            selectedTab = index
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: highlight ? 26 : 22))
                    .foregroundColor(
                        highlight ? .white :
                        (selectedTab == index ? Color.tabGreenDark : Color.tabGray)
                    )

                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(
                        highlight ? .white :
                        (selectedTab == index ? Color.tabGreenDark : Color.tabGray)
                    )
            }
            .frame(width: highlight ? 95 : 70, height: highlight ? 55 : 50)
            .background(
                highlight ?
                Color.tabGreenDark :
                Color.white
            )
            .cornerRadius(highlight ? 18 : 0)
            .shadow(
                color: highlight ? .black.opacity(0.12) : .clear,
                radius: highlight ? 6 : 0,
                y: highlight ? 3 : 0
            )
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppState())
        .environmentObject(UserModel())
        .environmentObject(ReportService())
}

