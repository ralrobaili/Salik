//
//  MainTabView.swift
//  SalikProject
//

import SwiftUI

struct MainTabView: View {

    @ObservedObject var reportStore: ReportStore
    @State private var selectedTab = 0

    var body: some View {
        VStack(spacing: 0) {

            ZStack {
                switch selectedTab {
                case 0:
                    HomePageView()

                case 1:
                    CaptureInstructionsView(reportStore: reportStore)

                case 2:
                    ReportsContentView()

                case 3:
                    AccountView()
                        .environmentObject(reportStore)

                default:
                    HomePageView()
                }
            }

            HStack(spacing: 0) {

                TabButton(
                    index: 3,
                    selectedTab: $selectedTab,
                    icon: "person.fill",
                    title: "حسابي"
                )

                Spacer()

                TabButton(
                    index: 2,
                    selectedTab: $selectedTab,
                    icon: "doc.text",
                    title: "التقارير"
                )

                Spacer()

                TabButton(
                    index: 1,
                    selectedTab: $selectedTab,
                    icon: "camera.fill",
                    title: "حادث جديد",
                    highlight: true
                )

                Spacer()

                TabButton(
                    index: 0,
                    selectedTab: $selectedTab,
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
        .background(Color(.systemGray6).ignoresSafeArea())
        .environmentObject(reportStore)
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
    MainTabView(reportStore: ReportStore())
}
