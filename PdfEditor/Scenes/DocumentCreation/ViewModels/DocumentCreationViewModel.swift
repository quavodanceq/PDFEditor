//
//  DocumentCreationViewModel.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 17.07.2025.
//

import Foundation
import PDFKit
import SwiftUI
import CoreData

class DocumentCreationViewModel: ObservableObject {
	
	private let router: AppRouter
	private var repository: PDFRepository?
	@Published var isRecognizingText: Bool = false
	
	init(router: AppRouter) {
		self.router = router
	}
	
	func setContext(_ context: NSManagedObjectContext) {
		self.repository = PDFRepository(context: context)
	}
	
	@MainActor
	func saveDocument(_ document: PDFDocument, firstPageImage: UIImage) async {
		guard let repository = repository else {
			print("Repository not initialized")
			return
		}
		
		isRecognizingText = true
		
		let title = await firstPageImage.recognizeTitle()
		
		if let pdfFile = repository.save(document: document, title: title, thumbnailImage: firstPageImage) {
			isRecognizingText = false
			router.presentFullScreen(screen: .documentDetail(document: pdfFile))
		} else {
			isRecognizingText = false
			print("save error")
		}
	}
	
	func cancelButtonTapped() {
		router.dissmissFullScreen()
	}
}
