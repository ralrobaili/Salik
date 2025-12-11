//  CameraStepsView.swift
//
//  SalikProject
//
//  Created by raghad alenezi on 16/06/1447 AH.
//
import SwiftUI

struct CameraStepsView: View {

    @ObservedObject var reportStore: ReportStore

    @State private var stepIndex = 0
    @State private var capturedImages: [UIImage] = []
    @State private var showCamera = false
    @State private var goToProcessing = false

    private let steps = [
        "صوّر مقدمة السيارة",
        "صوّر الجهة الخلفية",
        "صوّر الجهة اليمنى",
        "صوّر الجهة اليسرى",
        "صوّر موقع الحادث"
    ]

    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()

            VStack(spacing: 25) {

                Text("\(stepIndex + 1) / 5")
                    .font(.system(size: 22, weight: .semibold))
                    .padding(.top, 30)

                ProgressView(value: Double(stepIndex + 1), total: 5)
                    .tint(Color.tabGreenDark)
                    .padding(.horizontal, 40)

                Spacer()

                Text(steps[stepIndex])
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Spacer()
            }
        }

        .safeAreaInset(edge: .bottom) {
            VStack {
                Button {
                    showCamera = true
                } label: {
                    Text("التقاط الصورة")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.tabGreenDark)
                        .cornerRadius(16)
                        .padding(.horizontal)
                }
                .padding(.bottom, 12)
            }
            .background(Color.white)
            .shadow(color: .black.opacity(0.1), radius: 8, y: -2)
        }

        .fullScreenCover(isPresented: $showCamera) {
            CameraSystemView { image in
                capturedImages.append(image)

                if stepIndex < 4 {
                    stepIndex += 1
                } else {
                    showCamera = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        goToProcessing = true
                    }
                }
            }
        }

        .navigationDestination(isPresented: $goToProcessing) {
            AIProcessingView(
                images: capturedImages,
                reportStore: reportStore
            )
        }
    }
}

#Preview {
    NavigationStack {
        CameraStepsView(reportStore: ReportStore())
    }
}
