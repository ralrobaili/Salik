// StepRowView.swift
import SwiftUI

struct StepRowView: View {
    let title: String
    let stepIndex: Int
    let currentStep: Int
    let progress: Double

    var isCompleted: Bool { stepIndex < currentStep }
    var isCurrent: Bool { stepIndex == currentStep }
    var isPending: Bool { stepIndex > currentStep }

    var body: some View {
        HStack(spacing: 12) {

            // Status indicator
            ZStack {
                if isCompleted {
                    Circle()
                        .fill(Color.tabGreenDark.opacity(0.15))
                        .frame(width: 28, height: 28)
                    Image(systemName: "checkmark")
                        .foregroundColor(Color.tabGreenDark)
                        .font(.system(size: 14, weight: .bold))
                } else if isCurrent {
                    Circle()
                        .stroke(Color.tabGreenDark, lineWidth: 2)
                        .frame(width: 28, height: 28)
                    Circle()
                        .fill(Color.tabGreenDark)
                        .frame(width: 12, height: 12)
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 28, height: 28)
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
            }

            VStack(alignment: .trailing, spacing: 6) {
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                GeometryReader { geo in
                    let width: CGFloat = {
                        if isCompleted {
                            return geo.size.width
                        } else if isCurrent {
                            return geo.size.width * CGFloat(min(max(progress, 0.0), 1.0))
                        } else {
                            return 0
                        }
                    }()

                    return ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.18))
                            .frame(height: 6)

                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.tabGreenDark)
                            .frame(width: width, height: 6)
                            .animation(.linear(duration: 0.2), value: width)
                    }
                }
                .frame(height: 6)
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.03), radius: 3, y: 1)
    }
}

#Preview {
    VStack(spacing: 14) {
        StepRowView(title: "جاري التعرف على المركبات...", stepIndex: 0, currentStep: 1, progress: 1.0) // completed
        StepRowView(title: "تحليل مواقع الضرر...", stepIndex: 1, currentStep: 1, progress: 0.5) // current
        StepRowView(title: "تحديد اتجاهات السير...", stepIndex: 2, currentStep: 1, progress: 0.0) // pending
    }
    .padding()
    .background(Color(.systemGray6))
}
