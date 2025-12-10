import Foundation
import Combine

struct Report: Identifiable, Codable {
    let id: String
    let title: String
    let date: Date
    let location: String
    let severity: String
    let errorPercentage: Int
    let status: String
    let imageURLs: [String]

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ar_SA")
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: date)
    }
}

final class ReportService: ObservableObject {

    @Published var reports: [Report] = []

    init() {
        self.reports = [
            Report(
                id: UUID().uuidString,
                title: "تقرير حادث",
                date: Date(),
                location: "الرياض — طريق الملك فهد",
                severity: "خفيف",
                errorPercentage: 70,
                status: "تم الإرسال",
                imageURLs: []
            ),
            Report(
                id: UUID().uuidString,
                title: "تقرير حادث",
                date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(),
                location: "جدة — شارع التحلية",
                severity: "متوسط",
                errorPercentage: 30,
                status: "تم التحليل",
                imageURLs: []
            )
        ]
    }

    func addReport(_ report: Report) {
        reports.insert(report, at: 0)
    }
}
