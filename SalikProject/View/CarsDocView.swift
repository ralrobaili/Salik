//
//  CarsDocView.swift
//  SalikProject
//

import SwiftUI

struct ProgressBar: View {
    var percentage: Double
    var color: Color

    var body: some View {
        GeometryReader { geo in
            let progress = CGFloat(percentage / 100.0)

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 7)

                RoundedRectangle(cornerRadius: 4)
                    .fill(color)
                    .frame(width: geo.size.width * progress, height: 7)
            }
        }
        .frame(height: 7)
    }
}

struct CarsDocView: View {

    let images: [UIImage]

    @Environment(\.dismiss) private var dismiss
    @State private var openPDF = false
    @State private var pdfURL: URL?

    private var currentGregorianDate: String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "ar_SA")
        formatter.dateFormat = "d MMMM yyyy - h:mm a"
        return formatter.string(from: Date())
    }

    var body: some View {
        VStack(spacing: 0) {

            // الهيدر
            HStack {
                Button {
                    dismiss()    // <<< يرجع خطوة واحدة
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.trailing, 4)
                }

                Spacer()

                Text("نتائج التحليل")
                    .font(.system(size: 20, weight: .semibold))

                Spacer()

                Rectangle()
                    .frame(width: 24, height: 1)
                    .opacity(0)
            }
            .padding()
            .background(Color(.systemGray6))
            .overlay(
                Rectangle()
                    .frame(height: 0.6)
                    .foregroundColor(.black.opacity(0.1)),
                alignment: .bottom
            )

            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {

                    // تم التحليل بنجاح
                    HStack {
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("تم تحليل الحادث بنجاح")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color.tabGreenDark)

                            Text("التقرير جاهز للتحميل والإرسال")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)

                        ZStack {
                            Circle()
                                .fill(Color.tabGreenDark.opacity(0.15))
                                .frame(width: 40, height: 40)
                            Image(systemName: "checkmark")
                                .foregroundColor(Color.tabGreenDark)
                        }
                    }
                    .padding()
                    .background(Color(hex: "E6F3E8"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.tabGreenDark, lineWidth: 1.3)
                    )
                    .cornerRadius(18)
                    .shadow(color: .black.opacity(0.05), radius: 6, y: 3)

                    // الموقع والتاريخ
                    VStack(alignment: .trailing, spacing: 14) {

                        HStack {
                            VStack(alignment: .trailing, spacing: 3) {
                                Text("الرياض")
                                    .font(.system(size: 15, weight: .semibold))

                                Text("المملكة العربية السعودية")
                                    .font(.system(size: 13))
.foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)

                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.green)
                        }

                        Divider()

                        HStack {
                            Text(currentGregorianDate)
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .trailing)

                            Image(systemName: "calendar")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(18)
                    .shadow(color: .black.opacity(0.05), radius: 8, y: 3)

                    // تحليل الأضرار
                    VStack(alignment: .trailing, spacing: 14) {

                        HStack {
                            Text("تحليل الأضرار")
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                        }

                        HStack(spacing: 12) {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(hex: "F6F6F6"))
                                .frame(width: 90, height: 70)
                                .overlay(
                                    Image(systemName: "car.fill")
                                        .font(.system(size: 35))
                                        .foregroundColor(.gray)
                                )

                            VStack(alignment: .trailing, spacing: 8) {
                                HStack {
                                    VStack(alignment: .trailing) {
                                        Text("مستوى الضرر")
                                            .font(.system(size: 13))
                                            .foregroundColor(.gray)
                                        Text("خفيف")
                                            .font(.system(size: 15, weight: .semibold))
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        Text("موقع الضرر")
                                            .font(.system(size: 13))
                                            .foregroundColor(.gray)
                                        Text("أمامي يمين")
                                            .font(.system(size: 15, weight: .semibold))
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(18)
                    .shadow(color: .black.opacity(0.05), radius: 8, y: 3)

                    // تحديد المتسبب
                    let percentageA = 70.0
                    let percentageB = 30.0

                    VStack(alignment: .trailing, spacing: 18) {

                        HStack {
                            Text("تحديد المتسبب")
                                .font(.system(size: 16, weight: .semibold))

                            Spacer()

                            Image(systemName: "car.2")
                                .foregroundColor(Color.tabGreenDark)
                        }

                        VStack(spacing: 6) {
                            HStack {
                                Text("70%")
                                    .foregroundColor(.red)
                                    .font(.
system(size: 15, weight: .semibold))

                                Spacer()

                                Text("سيارتك")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)

                                Text("A").font(.system(size: 18, weight: .bold))
                                    .frame(width: 40, height: 40)
                                    .background(Color.red.opacity(0.15))
                                    .cornerRadius(10)
                                    .foregroundColor(.red)
                            }

                            ProgressBar(percentage: percentageA, color: .red)
                        }

                        VStack(spacing: 6) {
                            HStack {
                                Text("30%")
                                    .foregroundColor(Color.tabGreenDark)
                                    .font(.system(size: 15, weight: .semibold))

                                Spacer()

                                Text("السيارة الأخرى")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)

                                Text("B")
                                    .font(.system(size: 18, weight: .bold))
                                    .frame(width: 40, height: 40)
                                    .background(Color.tabGreenDark.opacity(0.15))
                                    .cornerRadius(10)
                                    .foregroundColor(Color.tabGreenDark)
                            }

                            ProgressBar(percentage: percentageB, color: Color.tabGreenDark)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(18)
                    .shadow(color: .black.opacity(0.05), radius: 8, y: 3)

                    // تفاصيل تقنية
                    VStack(alignment: .trailing, spacing: 12) {

                        Text("تفاصيل تقنية")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .trailing)

                        HStack {
                            VStack(alignment: .trailing) {
                                Text("نوع التصادم")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13))
                                Text("تصادم جانبي")
                                    .font(.system(size: 15, weight: .semibold))
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("حالة الطريق")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13))
                                Text("جيدة")
                                    .font(.system(size: 15, weight: .semibold))
                            }
                        }

                        HStack {
                            VStack(alignment: .trailing) {
                                Text("السرعة التقديرية")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13))
                                Text("25–35 كم/س")
                                    .font(.system(size: 15, weight: .semibold))
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("علامات الفرامل")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13))
                                Text("مخففة")
                                    .font(.system(size: 15, weight: .semibold))
                            }
                        }
                    }
                    .padding()
.background(Color.white)
                    .cornerRadius(18)
                    .shadow(color: .black.opacity(0.05), radius: 8, y: 3)

                    // صور الحادث (من الصور الحقيقية)
                    VStack(alignment: .trailing, spacing: 12) {
                        Text("صور الحادث")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .trailing)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ForEach(images.indices, id: \.self) { index in
                                Image(uiImage: images[index])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 90)
                                    .clipped()
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(18)
                    .shadow(color: .black.opacity(0.05), radius: 8, y: 3)

                    // أزرار PDF / إرسال
                    HStack(spacing: 14) {

                        Button {
                            let url = generatePDF()
                            self.pdfURL = url
                            self.openPDF = true
                        } label: {
                            HStack {
                                Image(systemName: "arrow.down.doc")
                                Text("تحميل PDF")
                            }
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "E5E5E7"))
                            .cornerRadius(14)
                        }

                        Button {
                            // هنا تضعين منطق الإرسال للتأمين لاحقاً
                        } label: {
                            HStack {
                                Image(systemName: "paperplane.fill")
                                Text("إرسال للتأمين")
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.tabGreenDark)
                            .cornerRadius(14)
                        }
                    }
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 18)
                .padding(.top)
            }
            .background(Color(.systemGray6))
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $openPDF) {
            if let pdfURL = pdfURL {
                GeneratedPDFView(pdfURL: pdfURL)
            }
        }
    }

    private func generatePDF() -> URL {
        let pdfMetaData = [
            kCGPDFContextCreator: "Salik App",
            kCGPDFContextAuthor: "AI Damage Analysis"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent("Report.pdf")

        let pageWidth: CGFloat = 8.5 * 72
        let pageHeight: CGFloat = 11 * 72
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

        try? renderer.writePDF(to: fileURL) { context in
            context.beginPage()

            let title = "تقرير تحليل الحادث"
            let attrs = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26)
            ]
            title.draw(at: CGPoint(x: 72, y: 72), withAttributes: attrs)

            let bodyText =
        """
        • الموقع: الرياض — طريق الملك فهد
        • التاريخ: \(Date().formatted(date: .complete, time: .shortened))

        • مستوى الضرر: خفيف
        • المتسبب: سيارتك A (70%)
        • السيارة الأخرى: B (30%)

        هذا التقرير تم توليده بواسطة الذكاء الاصطناعي.
        """

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 8

            let bodyAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 18),
                .paragraphStyle: paragraphStyle
            ]

            let textRect = CGRect(x: 72, y: 130, width: pageWidth - 144, height: pageHeight - 200)
            bodyText.draw(in: textRect, withAttributes: bodyAttributes)
        }

        return fileURL
    }
}

#Preview {
    NavigationStack {
        CarsDocView(images: [])
    }
}
