//
//  CameraView.swift
//  SalikProject
//
//  Created by raghad alenezi on 17/06/1447 AH.
//


import Combine
import SwiftUI
import UIKit

struct CameraView: UIViewControllerRepresentable {

    var onImagePicked: (UIImage?) -> Void

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {

        let picker = UIImagePickerController()

        picker.sourceType = .camera
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        picker.cameraCaptureMode = .photo
        picker.modalPresentationStyle = .fullScreen

        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        let parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            let image = info[.originalImage] as? UIImage
            picker.dismiss(animated: true) {
                self.parent.onImagePicked(image)
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true) {
                self.parent.onImagePicked(nil)
            }
        }
    }
}
