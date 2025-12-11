//
//  MainTapView.swift
//  SalikProject
//
//  Created by raghad alenezi on 16/06/1447 AH.
//
//
import SwiftUI

struct CustomTabBar: View {

    @Binding var selectedTab: Int
    var onCapture: () -> Void

    var body: some View {
        HStack {

            tabButton(index: 0, icon: "house.fill", title: "الرئيسية")

            Spacer()

            Button {
                onCapture()
            } label: {
                Image(systemName: "camera.fill")
                    .foregroundColor(.white)
                    .padding(18)
                    .background(Color.tabGreenDark)
                    .clipShape(Circle())
            }

            Spacer()

            tabButton(index: 2, icon: "doc.text", title: "التقارير")
            tabButton(index: 3, icon: "person.fill", title: "حسابي")

        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 6)
        .padding(.horizontal)
    }

    @ViewBuilder
    func tabButton(index: Int, icon: String, title: String) -> some View {
        Button {
            selectedTab = index
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .foregroundColor(selectedTab == index ? Color.tabGreenDark : .gray)
                Text(title)
                    .font(.system(size: 11))
                    .foregroundColor(selectedTab == index ? Color.tabGreenDark : .gray)
            }
        }
    }
}
