//
//  RecentFileCard.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 12.07.2025.
//
import SwiftUI

struct RecentFileCard: View {
	
	let document: PDFFile
	
	@EnvironmentObject var thumbnailCache: ThumbnailCacheService
	
	var body: some View {
		VStack(alignment: .leading) {
			Group {
				if let thumbnail = thumbnailCache.thumbnail(for: document) {
					Image(uiImage: thumbnail)
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
							ProgressView()
								.scaleEffect(1.2)
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
	}
}
