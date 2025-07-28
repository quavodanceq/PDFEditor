//
//  PDFRepositoryDeletionError.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 28.07.2025.
//

import Foundation

enum PDFRepositoryDeletionResult {
	case success
	case failure(PDFRepositoryDeletionError)
}

enum PDFRepositoryDeletionError: Error {
	case fileNotFoundInCoreData
	case coreDataSaveError(Error)
	case fileSystemError(PDFDeletionError)
	case partialFailure(String) // Когда файл удален из CoreData но не из файловой системы
	
	var localizedDescription: String {
		switch self {
		case .fileNotFoundInCoreData:
			return "Документ не найден в базе данных"
		case .coreDataSaveError(let error):
			return "Ошибка сохранения в базе данных: \(error.localizedDescription)"
		case .fileSystemError(let pdfError):
			return "Ошибка файловой системы: \(pdfError.localizedDescription)"
		case .partialFailure(let message):
			return "Частичная ошибка: \(message)"
		}
	}
}
