//
//  Created by raghad alenezi on 16/06/1447 AH.
//
//
//
import SwiftUI


struct ReportsContentView: View {

    @State private var reports: [ReportModel] = [
        ReportModel(
            status: "تم الإرسال",
            location: "الرياض، طريق الملك فهد",
            date: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 15))!,
            severity: "خفيف",
            errorPercentage: 70
        ),
        ReportModel(
            status: "تم التحليل",
            location: "جدة، شارع التحلية",
            date: Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 10))!,
            severity: "متوسط",
            errorPercentage: 30
        )
    ]

    var body: some View {

        VStack(spacing: 0) {

            ZStack {
                Color(.systemGray6).ignoresSafeArea(edges: .top)

                Text("التقارير")
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundColor(.black)
            }
            .frame(height: 80)

            ScrollView(showsIndicators: false) {

                VStack(spacing: 16) {
                    ForEach(reports) { report in
                        ReportCardView(report: report)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
        }
        .background(Color(.systemGray6))
    }
}


struct ReportCardView: View {

    var report: ReportModel

    var tagColor: Color {
        report.status == "تم الإرسال" ? .tabGreenDark : Color.blue
    }

    var severityColor: Color {
        switch report.severity {
        case "خفيف": return .tabGreenDark
        case "متوسط": return .orange
        default: return .red
        }
    }

    var body: some View {

        HStack(alignment: .top, spacing: 10) {

            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.systemGray6))
                    .frame(width: 48, height: 48)

                Image(systemName: "doc.text.fill")
                    .font(.system(size: 22))
                    .foregroundColor(.tabGreenDark)
            }

            VStack(alignment: .leading, spacing: 8) {

                HStack {
                    Text("تقرير حادث")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.black)

                    Spacer()

                    Text(report.status)
                        .font(.system(size: 12))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(tagColor.opacity(0.12))
                        .cornerRadius(8)
                        .foregroundColor(tagColor)
                }

                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                        .font(.system(size: 11))

                    Text(report.date.formatted(date: .long, time: .omitted))
                        .foregroundColor(.gray)
                        .font(.system(size: 13))

                    Spacer()
                }

                HStack(spacing: 4) {
                    Image(systemName: "location.fill")
                        .foregroundColor(.gray.opacity(0.7))
                        .font(.system(size: 11))

                    Text(report.location)
                        .foregroundColor(.gray)
                        .font(.system(size: 13))

                    Spacer()
                }

                HStack {

                    VStack(alignment: .leading, spacing: 1) {
                        Text("خطأ")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)

                        Text("\(report.errorPercentage)%")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.red)
                    }

                    Spacer()

                    HStack(spacing: 4) {
                        Text(report.severity)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(severityColor)

                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(severityColor)
                            .font(.system(size: 11))
                    }
                }
            }
        }
        .padding(14)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 3)
    }
}
#Preview {
    ReportsContentView()
}
