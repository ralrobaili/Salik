//  SalikProject
//
//  Created by raghad alenezi on 16/06/1447 AH.
//

import SwiftUI

struct AIProcessingView: View {

    let images: [UIImage]
    @ObservedObject var reportStore: ReportStore

    @State private var currentStep: Int = 0
    @State private var goToResult = false

    @State private var brainX: CGFloat = 0
    @State private var brainY: CGFloat = 0

    private let steps = [
        "جاري التعرف على المركبات...",
        "تحليل مواقع الأضرار...",
        "تحديد اتجاهات السير...",
        "حساب نسبة الخطأ...",
        "إنشاء التقرير..."
    ]

    private let totalSteps = 5

    var body: some View {

        ZStack {
            Color(.systemGray6).ignoresSafeArea()

            VStack(spacing: 24) {

                RoundedRectangle(cornerRadius: 22)
                    .fill(Color.tabGreenDark)
                    .frame(width: 115, height: 115)
                    .overlay(
                        Image("aibrain2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 72, height: 72)
                            .offset(x: brainX, y: brainY)
                    )
                    .padding(.top, 60)

                Text("جاري تحليل الحادث")
                    .font(.system(size: 22, weight: .semibold))

                Text("الذكاء الاصطناعي يحلل الصور...")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)

                Text("عدد الصور المختارة: \(images.count)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)

                // MARK: Steps Rows
                VStack(spacing: 16) {
                    ForEach(0..<steps.count, id: \.self) { index in
                        ProcessingStepRow(
                            stepIndex: index,
                            title: steps[index],
                            currentStep: currentStep
                        )
                    }
                }
                .padding(.horizontal)

                // MARK: Bottom Step Squares
                HStack(spacing: 12) {
                    ForEach(0..<totalSteps, id: \.self) { index in
                        StepSquare(
                            index: index,
                            current: currentStep
                        )
                    }
                }
                .padding(.top, 20)

                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            startBrainAnimation()
            startSteps()
        }
        .navigationDestination(isPresented: $goToResult) {
            CarsDocView(images: images)
        }
    }

    private func startBrainAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            let t = Date().timeIntervalSinceReferenceDate
            brainX = CGFloat(cos(t) * 4)
            brainY = CGFloat(sin(t) * 4)
        }
    }

    private func startSteps() {
        runStep(0)
    }

    private func runStep(_ step: Int) {

        if step >= totalSteps {
            finishReport()
            return
        }

        currentStep = step

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            runStep(step + 1)
        }
    }

    private func finishReport() {

        let newReport = Report(
            id: UUID().uuidString,
            title: "تقرير حادث",
            date: Date(),
            location: "يتم تحديد الموقع",
            severity: "خفيف",
            errorPercentage: 70,
            status: "تم التحليل"
        )

        reportStore.addReport(newReport)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            goToResult = true
        }
    }
}




struct ProcessingStepRow: View {
let stepIndex: Int
    let title: String
    let currentStep: Int

    @State private var rotation: Double = 0

    var isDone: Bool { stepIndex < currentStep }
    var isActive: Bool { stepIndex == currentStep }

    var body: some View {

        HStack {
            Spacer()

            Text(title)
                .foregroundColor(isDone ? .tabGreenDark : .gray)
                .font(.system(size: 15))

            ZStack {

                // الدائرة الشفافة الأساسية
                Circle()
                    .stroke(Color.gray.opacity(0.4), lineWidth: 3)
                    .frame(width: 28, height: 28)

                // الحلقة الدوارة
                if isActive {
                    Circle()
                        .trim(from: 0, to: 0.25)
                        .stroke(Color.tabGreenDark, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        .frame(width: 28, height: 28)
                        .rotationEffect(.degrees(rotation))
                        .animation(.linear(duration: 1.2).repeatForever(autoreverses: false), value: rotation)
                        .onAppear { rotation = 360 }
                }

                if isDone {
                    Circle()
                        .fill(Color.tabGreenDark.opacity(0.12))
                        .frame(width: 28, height: 28)

                    Image(systemName: "checkmark")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.tabGreenDark)
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isDone ? Color.tabGreenDark.opacity(0.10) : Color.white)
        )
        .shadow(color: .black.opacity(0.05), radius: 3)
    }
}




struct StepSquare: View {

    let index: Int
    let current: Int

    @State private var fill: CGFloat = 0.0
    @State private var scale: CGFloat = 1.0

    var isActive: Bool { index < current }

    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.25))

            RoundedRectangle(cornerRadius: 12)
                .fill(Color.tabGreenDark)
                .mask(
                    GeometryReader { geo in
                        Rectangle()
                            .frame(width: geo.size.width * fill)
                            .animation(.easeInOut(duration: 0.45), value: fill)
                    }
                )

            Text("\(index + 1)")
                .foregroundColor(.white)
                .font(.system(size: 17, weight: .bold))
        }
        .frame(width: 48, height: 48)
        .scaleEffect(scale)
        .onChange(of: current) { oldValue, newValue in
            if index == newValue - 1 {

                fill = 1.0

                withAnimation(.spring(response: 0.35, dampingFraction: 0.5)) {
                    scale = 1.15
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.6)) {
                        scale = 1.0
                    }
                }
            }
        }
        .onAppear {
            if isActive { fill = 1.0 }
        }
    }
}
