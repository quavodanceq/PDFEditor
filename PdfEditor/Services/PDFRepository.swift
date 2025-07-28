//
//  PDFManager.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 22.07.2025.
//

import Foundation
import PDFKit
import CoreData

final class PDFRepository {
	let context: NSManagedObjectContext
	
	private let pdfService = PDFService()
	
	init(context: NSManagedObjectContext) {
		self.context = context
	}
	
	func save(document: PDFDocument, title: String) -> PDFFile? {
		
		guard let pdfFile = pdfService.savePDFDocument(document, title: title) else {
			return nil
		}
		
		let entity = PDFFileEntity(context: context)
		entity.id = pdfFile.id
		entity.name = pdfFile.name
		entity.fileName = pdfFile.fileName
		entity.createdAt = pdfFile.createdAt
		
		do {
			try context.save()
			return pdfFile
		} catch let error{
			print("Failed to save to CoreData:", error)
			return nil
		}
	}
	
	func fetchAll() -> [PDFFile] {
		let request = PDFFileEntity.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
		let result = try? context.fetch(request)
		return result?.compactMap { PDFFile(entity: $0) } ?? []
	}
	
	func delete(_ file: PDFFile) -> PDFRepositoryDeletionResult {
		// Сначала находим entity в Core Data
		let request = PDFFileEntity.fetchRequest()
		request.predicate = NSPredicate(format: "id == %@", file.id as CVarArg)
		
		guard let results = try? context.fetch(request),
			  let entity = results.first else {
			return .failure(.fileNotFoundInCoreData)
		}
		
		// Сначала пытаемся удалить файл из файловой системы
		do {
			try pdfService.deleteFile(fileName: file.fileName)
		} catch let error as PDFDeletionError {
			// Если не удалось удалить файл, возвращаем ошибку
			return .failure(.fileSystemError(error))
		} catch {
			// Неожиданная ошибка
			return .failure(.fileSystemError(.unknownError(error)))
		}
		
		// Если файл успешно удален, удаляем из Core Data
		context.delete(entity)
		
		do {
			try context.save()
			return .success
		} catch let error {
			// Если не удалось сохранить изменения в Core Data
			// Пытаемся откатить изменения
			context.rollback()
			
			// Файл уже удален из файловой системы, но Core Data не обновлена
			// Это состояние частичной ошибки
			return .failure(.partialFailure("Файл удален из файловой системы, но не удалось обновить базу данных. Требуется ручное исправление."))
		}
	}
}

