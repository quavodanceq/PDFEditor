//
//  PDFService.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 22.07.2025.
//

import PDFKit
import Vision

enum PDFDeletionError: Error {
	case fileNotFound
	case permissionDenied
	case unknownError(Error)
	
	var localizedDescription: String {
		switch self {
		case .fileNotFound:
			return "Файл не найден"
		case .permissionDenied:
			return "Нет разрешения на удаление файла"
		case .unknownError(let error):
			return "Неизвестная ошибка: \(error.localizedDescription)"
		}
	}
}

class PDFService {
	
	func savePDFDocument(_ document: PDFDocument, title: String, thumbnailImage: UIImage) -> PDFFile? {
		let id = UUID()
		let fileName = "\(id.uuidString).pdf"
		let thumbnailFileName = "\(id.uuidString)_thumbnail.jpg"
		
		guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
			return nil
		}
		
		let pdfURL = documentsDirectory.appendingPathComponent(fileName)
		guard document.write(to: pdfURL) else {
			return nil
		}
		let thumbnailURL = documentsDirectory.appendingPathComponent(thumbnailFileName)
		if let thumbnailData = thumbnailImage.jpegData(compressionQuality: 0.8) {
			try? thumbnailData.write(to: thumbnailURL)
		}
		
		
		return PDFFile(
			id: id,
			name: title,
			fileName: fileName,
			createdAt: Date(),
			thumbnailFileName: thumbnailFileName)
	}
	
	func loadDocument(for item: PDFFile) -> PDFDocument? {
		guard let url = FileManager.default
			.urls(for: .documentDirectory, in: .userDomainMask)
			.first?.appendingPathComponent(item.fileName) else {
			return nil
		}
		return PDFDocument(url: url)
	}
	
	func loadThumbnail(for item: PDFFile) -> UIImage? {
		guard let thumbnailURL = item.thumbnailURL,
			  FileManager.default.fileExists(atPath: thumbnailURL.path) else {
			return nil
		}
		return UIImage(contentsOfFile: thumbnailURL.path)
	}
	
	func deleteFile(fileName: String) throws {
		guard let url = FileManager.default
			.urls(for: .documentDirectory, in: .userDomainMask)
			.first?.appendingPathComponent(fileName) else {
			throw PDFDeletionError.fileNotFound
		}
		
		guard FileManager.default.fileExists(atPath: url.path) else {
			throw PDFDeletionError.fileNotFound
		}
		
		do {
			try FileManager.default.removeItem(at: url)
		} catch let error as NSError {
			if error.code == NSFileReadNoPermissionError || error.code == NSFileWriteNoPermissionError {
				throw PDFDeletionError.permissionDenied
			} else {
				throw PDFDeletionError.unknownError(error)
			}
		}
		
		// Также удаляем thumbnail если есть
		let thumbnailFileName = fileName.replacingOccurrences(of: ".pdf", with: "_thumbnail.jpg")
		if let thumbnailURL = FileManager.default
			.urls(for: .documentDirectory, in: .userDomainMask)
			.first?.appendingPathComponent(thumbnailFileName),
		   FileManager.default.fileExists(atPath: thumbnailURL.path) {
			try? FileManager.default.removeItem(at: thumbnailURL)
		}
	}
}

