//
//  DocumentDetailViewModel.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 17.07.2025.
//

import Foundation
import PDFKit

class DocumentDetailViewModel: ObservableObject {
	
	private let router: AppRouter
	
	let document: PDFFile
	
	var pdfDocument: PDFDocument? {
		guard let url = document.fileURL else { return nil }
		return PDFDocument(url: url)
	}
	
	init(document: PDFFile, router: AppRouter) {
		self.document = document
		self.router = router
	}
	
	func backButtonTapped() {
		router.dissmissFullScreen()
	}
	
}
