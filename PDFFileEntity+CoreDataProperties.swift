//
//  PDFFileEntity+CoreDataProperties.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 28.07.2025.
//
//

import Foundation
import CoreData


extension PDFFileEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PDFFileEntity> {
        return NSFetchRequest<PDFFileEntity>(entityName: "PDFFileEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var fileName: String?
    @NSManaged public var createdAt: Date?

}

extension PDFFileEntity : Identifiable {

}
