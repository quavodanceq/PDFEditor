//
//  PDFDocument.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 12.07.2025.
//
import Foundation

struct PDFFile: Identifiable, Hashable {
	let id: UUID
	let name: String
	let fileName: String
	let createdAt: Date
	var fileURL: URL? {
		FileManager.default
			.urls(for: .documentDirectory, in: .userDomainMask)
			.first?
			.appendingPathComponent(fileName)
	}
	
	var fileSize: Double {
		guard let fileURL = fileURL,
			  let attributes = try? FileManager.default.attributesOfItem(atPath: fileURL.path),
			  let fileSize = attributes[.size] as? UInt64 else {
			return 0.0
		}
		
		// Конвертируем байты в мегабайты
		return Double(fileSize) / (1024 * 1024)
	}
}

extension PDFFile {
	init?(entity: PDFFileEntity) {
		guard let id = entity.id,
			  let name = entity.name,
			  let fileName = entity.fileName,
			  let createdAt = entity.createdAt else {
			return nil
		}
		self.init(id: id, name: name, fileName: fileName, createdAt: createdAt)
	}
}
