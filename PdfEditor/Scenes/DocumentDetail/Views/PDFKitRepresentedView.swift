//
//  PDFKitRepresentedView.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 17.07.2025.
//

import SwiftUI
import PDFKit

struct PDFKitRepresentedView: UIViewRepresentable {
	
	let document: PDFDocument?
	
	func updateUIView(_ uiView: PDFView, context: Context) {
		
	}
	
	func makeUIView(context: Context) -> PDFView {
		let view = PDFView()
		view.document = document
		view.autoScales = true
		return view
	}
	
}
