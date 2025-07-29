//
//  Untitled.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 12.07.2025.
//
import SwiftUI

struct RecentFileCard: View {
	let document: PDFFile
	@State private var thumbnailImage: UIImage?
	
	var body: some View {
		VStack(alignment: .leading) {
			Group {
				if let thumbnailImage = thumbnailImage {
					Image(uiImage: thumbnailImage)
						.resizable()
						.scaledToFill()
						.frame(width: 160, height: 200)
						.clipped()
						.cornerRadius(8)
				} else {
					Rectangle()
						.fill(Color.gray.opacity(0.2))
						.frame(width: 160, height: 200)
						.overlay(
							Image(systemName: "doc.text.fill")
								.resizable()
								.scaledToFit()
								.frame(width: 60)
								.foregroundColor(.gray)
						)
						.cornerRadius(8)
				}
			}
			
			Text(document.name)
				.font(.subheadline)
				.lineLimit(1)
			
			Text("Modified: \(document.createdAt.formatted(.dateTime.month().day().year()))")
				.font(.caption)
				.foregroundColor(.gray)
		}
		.frame(width: 160)
		.onAppear {
			loadThumbnail()
		}
	}
	
	private func loadThumbnail() {
		let pdfService = PDFService()
		thumbnailImage = pdfService.loadThumbnail(for: document)
	}
}
