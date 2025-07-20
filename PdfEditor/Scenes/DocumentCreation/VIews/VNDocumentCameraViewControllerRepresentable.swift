//
//  VNDocumentCameraViewControllerRepresentable.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 16.07.2025.
//

import SwiftUI
import VisionKit
import PDFKit

struct VNDocumentCameraViewControllerRepresentable: UIViewControllerRepresentable {
	
	@ObservedObject private var viewModel: DocumentCreationViewModel
	
	init(viewModel: DocumentCreationViewModel) {
		self.viewModel = viewModel
	}
	
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
		
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
		
        var parent: VNDocumentCameraViewControllerRepresentable
        
        init(_ parent: VNDocumentCameraViewControllerRepresentable) {
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
			
			let pdf = PDFDocument()
			
			for i in 0..<scan.pageCount {
				let image = scan.imageOfPage(at: i)
				if let pdfPage = PDFPage(image: image) {
					pdf.insert(pdfPage, at: pdf.pageCount)
				}
			}
			parent.viewModel.saveDocument(pdf)
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
			parent.viewModel.cancelButtonTapped()
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            print("Document camera view controller did fail with error: \(error.localizedDescription)")
            
        }
    }
}
