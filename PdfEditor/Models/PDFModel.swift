//
//  PDFDocument.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 12.07.2025.
//
import Foundation

struct PDFModel: Identifiable {
    let id: UUID
    let name: String
    let dateModified: Date
    let size: Double // in MB
    
    init(id: UUID = UUID(), name: String, dateModified: Date, size: Double) {
        self.id = id
        self.name = name
        self.dateModified = dateModified
        self.size = size
    }
}
