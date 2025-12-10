import SwiftUI
import Combine

struct Report: Identifiable, Codable {
    let id: String
    let title: String
    let date: Date
    let location: String
    let severity: String
    let errorPercentage: Int
    let status: String
}

class ReportStore: ObservableObject {

    @Published var reports: [Report] = [] {
        didSet { saveReports() }
    }

    private let key = "savedReports"

    init() {
        loadReports()
    }

    func addReport(_ report: Report) {
        reports.append(report)
    }

    private func saveReports() {
        if let encoded = try? JSONEncoder().encode(reports) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    private func loadReports() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Report].self, from: data) {
            reports = decoded
        }
    }
}
