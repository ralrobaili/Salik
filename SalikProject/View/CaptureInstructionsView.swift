//  CaptureInstructionsView.swift
//  SalikProject
//
//
//  Created by raghad alenezi on 16/06/1447 AH.
//

import SwiftUI

struct CaptureInstructionsView: View {

    @ObservedObject var reportStore: ReportStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 22) {

                Text("تعليمات التصوير")
                    .font(.system(size: 22, weight: .semibold))
                    .padding(.top, 15)

                VStack(alignment: .trailing, spacing: 18) {

                    HStack {
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("طريقة التصوير الصحيحة")
                                .font(.system(size: 17, weight: .semibold))

                            Text("5 صور مطلوبة")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)

                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(hex: "#CDE6C6"))
                            .frame(width: 55, height: 55)
                            .overlay(
                                Image(systemName: "camera.fill")
                                    .foregroundColor(Color.tabGreenDark)
                                    .font(.system(size: 26))
                            )
                    }

                    Group {
                        captureItem(number: "1", title: "الجهة الأمامية", subtitle: "صور مقدمة السيارة")
                        captureItem(number: "2", title: "الجهة الخلفية", subtitle: "صور الواجهة الخلفية للسيارة")
                        captureItem(number: "3", title: "الجهة اليمنى", subtitle: "صور الجانب الأيمن")
                        captureItem(number: "4", title: "الجهة اليسرى", subtitle: "صور الجانب الأيسر")
                        captureItem(number: "5", title: "صورة الموقع", subtitle: "صور المشهد العام للحادث")
                    }

                }
                .padding()
                .background(Color.white.opacity(0.95))
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.black.opacity(0.07), lineWidth: 1.2)
                )
                .shadow(color: .black.opacity(0.12), radius: 12, x: 0, y: 6)
                .padding(.horizontal)

                VStack(alignment: .trailing, spacing: 12) {
                    Text("نصائح مهمة")
                        .font(.system(size: 17, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .trailing)

                    tipRow(text: "تأكد من وضوح الصورة وعدم وجود ظلال")
                    tipRow(text: "خذ الصورة من مسافة مناسبة (٢–٣ أمتار)")
                    tipRow(text: "تأكد من ظهور الأضرار بوضوح")
                }
                .padding()
                .background(Color(hex: "#F6F2EE"))
                .cornerRadius(25)
                .padding(.horizontal)

                Spacer().frame(height: 80)
            }
        }
        .safeAreaInset(edge: .bottom) {
            NavigationLink {
                CameraStepsView(reportStore: reportStore)
            } label: {
                HStack {
                    Text("ابدأ التصوير")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))

                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.tabGreenDark)
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
            .background(Color(.systemGray6))
        }
    }
}

private func captureItem(number: String, title: String, subtitle: String) -> some View {
    HStack {
        VStack(alignment: .trailing, spacing: 3) {
            Text(title)
                .font(.
system(size: 16, weight: .semibold))

            Text(subtitle)
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }

        ZStack {
            Circle()
                .fill(Color(hex: "#E6F3E8"))
                .frame(width: 32, height: 32)

            Text(number)
                .foregroundColor(Color.tabGreenDark)
                .font(.system(size: 15, weight: .bold))
        }
    }
    .frame(maxWidth: .infinity, alignment: .trailing)
    .padding(.vertical, 6)
}

private func tipRow(text: String) -> some View {
    HStack {
        Text(text)
            .font(.system(size: 15))
            .foregroundColor(.gray)

        Circle()
            .fill(Color.orange)
            .frame(width: 8, height: 8)
    }
}

#Preview {
    NavigationStack {
        CaptureInstructionsView(reportStore: ReportStore())
    }
}
