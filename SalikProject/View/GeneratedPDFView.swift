//
//  GeneratedPDFView.swift
//  SalikProject
//
//  Created by raghad alenezi on 17/06/1447 AH.
//
import SwiftUI
import PDFKit

struct GeneratedPDFView: View {
    let pdfURL: URL

    var body: some View {
        VStack {
            PDFKitView(url: pdfURL)
                .edgesIgnoringSafeArea(.bottom)

            ShareLink(item: pdfURL) {
                Label("مشاركة", systemImage: "square.and.arrow.up")
                    .font(.system(size: 18, weight: .medium))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.tabGreenDark)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding()
            }
        }
        .navigationTitle("ملف الحادث")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}
