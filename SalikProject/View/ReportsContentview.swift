import SwiftUI

struct ReportsContentView: View {

    @ObservedObject var reportStore: ReportStore

    var body: some View {

        VStack(alignment: .trailing) {

            Text("التقارير")
                .font(.system(size: 22, weight: .semibold))
                .padding()

            if reportStore.reports.isEmpty {
                Spacer()
                Text("لا توجد تقارير حتى الآن")
                    .foregroundColor(.gray)
                Spacer()
            }

            ScrollView {
                VStack(spacing: 16) {
                    ForEach(reportStore.reports.reversed()) { report in

                        VStack(alignment: .trailing, spacing: 6) {

                            HStack {
                                Text(report.status)
                                    .foregroundColor(.tabGreenDark)
                                    .font(.system(size: 13))

                                Spacer()

                                Text("تقرير حادث")
                                    .font(.system(size: 18, weight: .semibold))
                            }

                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundColor(.gray)

                                Text(report.location)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                            }

                            HStack {
                                Image(systemName: "calendar")
                                    .foregroundColor(.gray)

                                Text(report.date.formatted(date: .abbreviated, time: .shortened))
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                            }

                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.orange)

                                Text(report.severity)
                                    .font(.system(size: 14))

                                Spacer()

                                Text("\(report.errorPercentage)%")
                                    .foregroundColor(.red)
                                    .font(.system(size: 15, weight: .bold))
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(18)
                        .shadow(color: .black.opacity(0.05), radius: 6)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
