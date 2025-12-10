//
//  AIProcessingView.swift
//  SalikProject
//

import SwiftUI

struct AIProcessingView: View {

    let images: [UIImage]
    @ObservedObject var reportStore: ReportStore

    @State private var currentStep: Int = 0
    @State private var progress: Double = 0.0
    @State private var goToResult = false

    private let steps = [
        "جاري التعرف على المركبات...",
        "تحليل مواقع الضرر...",
        "تحديد اتجاهات السير...",
        "حساب نسبة الخطأ لكل طرف...",
        "إعداد التقرير..."
    ]

    private let totalIndicators = 5

    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()

            VStack(spacing: 24) {

                RoundedRectangle(cornerRadius: 22)
                    .fill(Color.tabGreenDark)
                    .frame(width: 120, height: 120)
                    .overlay(
                        Image("aibrain2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                    )
                    .padding(.top, 60)

                Text("جاري تحليل الحادث")
                    .font(.system(size: 22, weight: .semibold))

                Text("الذكاء الاصطناعي يحلل الصورة...")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)

                Text("عدد الصور المختارة: \(images.count)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)

                VStack(spacing: 14) {
                    ForEach(steps.indices, id: \.self) { index in
                        StepRowView(
                            title: steps[index],
                            stepIndex: index,
                            currentStep: currentStep,
                            progress: progress
                        )
                    }
                }
                .padding(.top, 12)
                .padding(.horizontal)

                HStack(spacing: 10) {
                    ForEach(0..<totalIndicators, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(index <= currentStep ? Color.tabGreenDark
                                                       : Color.gray.opacity(0.25))
                            .frame(width: 46, height: 46)
                            .overlay(
                                Text("\(index + 1)")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .bold))
                            )
                    }
                }
                .padding(.top, 16)

                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            startProcessing()
        }
        .navigationDestination(isPresented: $goToResult) {
            CarsDocView(images: images)
        }
    }

    // MARK: - Logic

    private func startProcessing() {
        sendImagesToServer(images)
        currentStep = 0
        runStep(step: 0)
    }

    private func runStep(step: Int) {

        if step == totalIndicators {
            currentStep = totalIndicators - 1
            createReportAndFinish()
            return
        }

        currentStep = step
        progress = 0.0

        withAnimation(.linear(duration: 2.0)) {
            progress = 1.0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            runStep(step: step + 1)
        }
    }

    private func createReportAndFinish() {

        let newReport = Report(
            id: UUID().uuidString,
            title: "تقرير حادث",
            date: Date(),
            location: "لم يتم تحديد الموقع بعد",
            severity: "خفيف",
            errorPercentage: 70,
            status: "تم التحليل",
           // imageURLs: [ ]  // حالياً فاضية
        )

        reportStore.addReport(newReport)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            goToResult = true
        }
    }

    private func sendImagesToServer(_ images: [UIImage]) {
        print("تم إرسال \(images.count) صورة للتحليل (وهميًا الآن)")
    }
}

#Preview {
    NavigationStack {
        AIProcessingView(images: [], reportStore: ReportStore())
    }
}
