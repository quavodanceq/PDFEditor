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
	
	let document: PDFDocument
	
	
	init(document: PDFDocument, router: AppRouter) {
		self.document = document
		self.router = router
	}
	
	func backButtonTapped() {
		router.dissmissFullScreen()
	}
	
}
