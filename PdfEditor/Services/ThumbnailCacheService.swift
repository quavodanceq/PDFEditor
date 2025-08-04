import SwiftUI
import UIKit

class ThumbnailCacheService: ObservableObject {
	
	@MainActor @Published var thumbnails: [UUID: UIImage] = [:]
	
	private var loadingDocuments: Set<UUID> = []
	private var loadingTasks: [UUID: Task<Void, Never>] = [:]
	private let pdfService = PDFService()
	private let maxConcurrentLoads = 3
	
	@MainActor func thumbnail(for document: PDFFile) -> UIImage? {		
		if let cached = thumbnails[document.id] {
			return cached
		}
		
		if loadingDocuments.contains(document.id) {
			return nil
		}
		
		startLoadingIfNeeded(for: document)
		return nil
	}
	
	private func startLoadingIfNeeded(for document: PDFFile) {
		guard !loadingDocuments.contains(document.id),
			  loadingDocuments.count < maxConcurrentLoads else {
			return
		}
		
		loadingDocuments.insert(document.id)
		
		let task = Task { [weak self] in
			let thumbnail = await Task.detached {
				return self?.pdfService.loadThumbnail(for: document)
			}.value
			
			await MainActor.run { [weak self] in
				guard let self = self else { return }
				
				if let thumbnail = thumbnail {
					self.thumbnails[document.id] = thumbnail
				}
				
				self.loadingDocuments.remove(document.id)
				self.loadingTasks.removeValue(forKey: document.id)
			}
		}
		
		loadingTasks[document.id] = task
	}
	
	@MainActor func clearCache() {
		thumbnails.removeAll()
		loadingDocuments.removeAll()
		loadingTasks.values.forEach { $0.cancel() }
		loadingTasks.removeAll()
	}
}
