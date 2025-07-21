//
//  DocumentCreationViewModel.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 17.07.2025.
//

import Foundation
import PDFKit
import SwiftUI

class DocumentCreationViewModel: ObservableObject {
	
	private let router: AppRouter
	
	init(router: AppRouter) {
		self.router = router
	}
	
	func saveDocument(_ document: PDFDocument) {
		router.presentFullScreen(screen: .documentDetail(document: document))
	}
	
	func cancelButtonTapped() {
		router.dissmissFullScreen()
	}
	
}
