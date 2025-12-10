import SwiftUI

struct AIProcessingView: View {

    let images: [UIImage]

    @State private var currentStep: Int = 0
    @State private var progress: Double = 0.0
    @State private var goToResult = false

    @EnvironmentObject var appState: AppState
    @EnvironmentObject var reportService: ReportService

    let steps = [
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

    func startProcessing() {
        sendImagesToServer(images)
        currentStep = 0
        runStep(step: 0)
    }

    func runStep(step: Int) {

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

    func createReportAndFinish() {

        let newReport = Report(
            id: UUID().uuidString,
            title: "تقرير حادث",
            date: Date(),
            location: "لم يتم تحديد الموقع بعد",
            severity: "خفيف",
            errorPercentage: 70,
            status: "تم التحليل",
            imageURLs: []
        )

     //   reportService.addReport(newReport)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            goToResult = true
        }
    }

    func sendImagesToServer(_ images: [UIImage]) {
print("🚀 تم إرسال \(images.count) صورة للتحليل (وهميًا الآن)")
    }
}

struct StepRowView: View {

    let title: String
    let stepIndex: Int
    let currentStep: Int
    let progress: Double

    var body: some View {

        let isCompleted = stepIndex < currentStep
        let isCurrent = stepIndex == currentStep

        HStack(spacing: 12) {

            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .trailing)

            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.35), lineWidth: 2)
                    .frame(width: 24, height: 24)

                if isCompleted {
                    Circle()
                        .fill(Color.tabGreenDark)
                        .frame(width: 24, height: 24)

                    Image(systemName: "checkmark")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)

                } else if isCurrent {
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(
                            Color.tabGreenDark,
                            style: StrokeStyle(lineWidth: 3, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .frame(width: 24, height: 24)
                }
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 18)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 6, y: 3)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
        )
        .padding(.horizontal, 6)
    }
}

#Preview {
    NavigationStack {
        AIProcessingView(images: [])
            .environmentObject(AppState())
            .environmentObject(ReportService())
    }
}
