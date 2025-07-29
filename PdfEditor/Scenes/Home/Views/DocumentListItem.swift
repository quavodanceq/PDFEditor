//
//  DocumentListItem.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 12.07.2025.
//
import SwiftUI
import UIKit

struct DocumentListItem: View {
	let document: PDFFile
	@State private var thumbnailImage: UIImage?
	
	var body: some View {
		HStack {
			Group {
				if let thumbnailImage = thumbnailImage {
					Image(uiImage: thumbnailImage)
						.resizable()
						.scaledToFit()
						.frame(width: 30)
						.cornerRadius(4)
				} else {
					Image(systemName: "doc.text.fill")
						.resizable()
						.scaledToFit()
						.frame(width: 30)
						.foregroundColor(.gray)
				}
			}
			
			VStack(alignment: .leading, spacing: 4) {
				Text(document.name)
					.font(.body)
				
				Text("\(String(format: "%.1f", document.fileSize)) MB • \(document.createdAt.formatted(.dateTime.month().day().year()))")
					.font(.caption)
					.foregroundColor(.gray)
			}
			
			Spacer()
			
			Button {
				// More options
			} label: {
				Image(systemName: "ellipsis")
					.foregroundColor(.gray)
			}
		}
		.padding(.vertical, 8)
		.onAppear {
			loadThumbnail()
		}
	}
	
	private func loadThumbnail() {
		let pdfService = PDFService()
		thumbnailImage = pdfService.loadThumbnail(for: document)
	}
}
