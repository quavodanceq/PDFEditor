//
//  Untitled.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 12.07.2025.
//
import SwiftUI

struct RecentFileCard: View {
	let document: PDFFile
	
	var body: some View {
		VStack(alignment: .leading) {
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
