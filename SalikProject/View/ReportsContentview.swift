//
//  ReportsContentView.swift
//  SalikProject
//
//  Created by raghad alenezi on 16/06/1447 AH.
//

import SwiftUI

struct ReportsContentView: View {

    @EnvironmentObject var reportService: ReportService

    var body: some View {

        VStack(spacing: 0) {

            HStack {
                Spacer()
                Text("التقارير")
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            .overlay(
                Rectangle()
                    .frame(height: 0.6)
                    .foregroundColor(Color.black.opacity(0.12)),
                alignment: .bottom
            )

            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    ForEach(reportService.reports) { report in
                        reportCard(report)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 15)
            }
            .background(Color(.systemGray6))
        }
    }

    @ViewBuilder
    func reportCard(_ r: Report) -> some View {

        VStack(alignment: .trailing, spacing: 14) {

            HStack {
                Text(r.status)
                    .font(.system(size: 12, weight: .medium))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .background(Color.green.opacity(0.18))
                    .cornerRadius(12)

                Spacer()

                HStack(spacing: 10) {
                    Text(r.title)
                        .font(.system(size: 18, weight: .semibold))

                    Image(systemName: "doc.text.image")
                        .font(.system(size: 30))
                        .foregroundColor(Color.tabGreenDark)
                }
            }

            HStack {
                Image(systemName: "clock")
                    .foregroundColor(.gray)
                Text(r.formattedDate)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)

                Spacer()

                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(Color.tabGreenDark)
                Text(r.location)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }

            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(Color.orange.opacity(0.65))
                Text(r.severity)
                    .font(.system(size: 14))
                    .foregroundColor(Color.orange.opacity(0.75))

                Spacer()

                Text("خطأ \(r.errorPercentage)%")
                    .font(.system(size: 14))
                    .foregroundColor(.red)
            }

        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.06), radius: 6, y: 3)
    }
}

#Preview {
    ReportsContentView()
        .environmentObject(ReportService())
}
