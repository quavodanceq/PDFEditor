//
//  DocumentListItem.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 12.07.2025.
//
import SwiftUI

struct DocumentListItem: View {
	let document: PDFFile
	
	@EnvironmentObject var thumbnailCache: ThumbnailCacheService
	
	var body: some View {
		HStack {
			Group {
				if let thumbnail = thumbnailCache.thumbnail(for: document) {
					Image(uiImage: thumbnail)
						.resizable()
						.scaledToFit()
						.frame(width: 30, height: 30)
						.cornerRadius(4)
				} else {
					ProgressView()
						.frame(width: 30, height: 30)
						.scaleEffect(0.7)
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
	}
}
