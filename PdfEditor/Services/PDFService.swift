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
	
	func savePDFDocument(_ document: PDFDocument, title: String) -> PDFFile? {
		
		let id = UUID()
		let fileName = "\(id.uuidString).pdf"
		guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName), document.write(to: documentsDirectory)
		else {
			return nil
		}
		return PDFFile(id: id, name: title, fileName: fileName, createdAt: Date())
	}
	
	func loadDocument(for item: PDFFile) -> PDFDocument? {
		guard let url = FileManager.default
			.urls(for: .documentDirectory, in: .userDomainMask)
			.first?.appendingPathComponent(item.fileName) else {
			return nil
		}
		return PDFDocument(url: url)
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
	}
}

