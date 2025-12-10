//
//  HomePageView.swift
//  SalikProject
//

import SwiftUI

struct HomePageView: View {

    private var displayName: String { "ضيف" }
    private var firstLetter: String { String(displayName.prefix(1)) }

    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()

            VStack(alignment: .trailing, spacing: 0) {

                // HEADER
                HStack {
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("مرحباً،")
                            .font(.system(size: 18))
                            .frame(maxWidth: .infinity, alignment: .trailing)

                        HStack(spacing: 4) {
                            Text(displayName)
                                .font(.system(size: 24, weight: .bold))
                            Text("👋")
                                .font(.system(size: 24))
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }

                    ZStack {
                        RoundedRectangle(cornerRadius: 22)
                            .fill(Color.tabGreenDark)
                            .frame(width: 60, height: 60)

                        Text(firstLetter)
                            .foregroundColor(.white)
                            .font(.system(size: 28, weight: .bold))
                    }
                }
                .padding(.horizontal)
                .padding(.top, 24)

                // EMERGENCY
                HStack {
                    VStack(alignment: .trailing, spacing: 6) {
                        Text("في حالة الطوارئ")
                            .font(.system(size: 18, weight: .semibold))

                        Text("إذا كان هناك إصابات، اتصل فوراً على 911")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                    }

                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hex: "#FFE7D6"))
                        .frame(width: 55, height: 55)
                        .overlay(
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                                .font(.system(size: 24))
                        )
                }
                .padding()
                .background(Color(hex: "#FCEAE2"))
                .cornerRadius(25)
                .padding(.horizontal)
                .padding(.top, 20)

                // TITLE
                Text("معلومات تساعدك قبل توثيق الحادث")
                    .font(.system(size: 20, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                    .padding(.top, 10)

                // CONTENT
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 25) {

                        Spacer().frame(height: 12)

                        infoCard(
                            title: "كيف تصوّر الحادث؟",
                            icon: "camera.fill",
                            iconColor: "#CDE6C6",
                            bullets: [
                                "صوّر كل الجهات (أمام، خلف، يمين، يسار)",
                                "خذ صورة واضحة للأضرار",
                                "التقط صورة عامة للموقع"
                            ])

                        infoCard(
                            title: "كيف يعمل الذكاء الاصطناعي؟",
                            icon: "aibrain",
                            iconColor: "#D7EDD6",
                            bullets: [
                                "يتعرف على السيارة تلقائيًا",
                                "يحدد موقع الضرر بدقة",
                                "يحلل اتجاه السير والمركبات",
                                "يحسب نسبة الخطأ لكل طرف"
                            ])

                        infoCard(
                            title: "ماذا تفعل بعد الحادث؟",
icon: "shield.checkerboard",
                            iconColor: "#E8F5E7",
                            bullets: [
                                "قف في مكان آمن بعيدًا عن الطريق",
                                "شغّل الفلشر والإشارات التحذيرية",
                                "وثّق الحادث بالتطبيق",
                                "أرسل التقرير للتأمين"
                            ])

                        Spacer().frame(height: 80)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

private func infoCard(title: String, icon: String, iconColor: String, bullets: [String]) -> some View {
    VStack(alignment: .trailing, spacing: 14) {

        HStack {
            VStack(alignment: .trailing, spacing: 8) {

                Text(title)
                    .font(.system(size: 18, weight: .semibold))

                ForEach(bullets, id: \.self) { text in
                    HStack {
                        Text(text)
                            .font(.system(size: 15))
                            .multilineTextAlignment(.trailing)

                        Circle()
                            .fill(Color.tabGreenDark)
                            .frame(width: 8, height: 8)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)

            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: iconColor))
                .frame(width: 65, height: 65)
                .overlay(
                    Group {
                        if UIImage(named: icon) != nil {
                            Image(icon)
                                .resizable()
                                .scaledToFit()
                                .padding(12)
                        } else {
                            Image(systemName: icon)
                                .foregroundColor(Color.tabGreenDark)
                                .font(.system(size: 26))
                        }
                    }
                )
        }
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: .black.opacity(0.07), radius: 10, x: 0, y: 4)
    }
}

#Preview {
    HomePageView()
}
