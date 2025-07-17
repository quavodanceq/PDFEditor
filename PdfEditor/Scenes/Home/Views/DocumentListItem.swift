//
//  DocumentListItem.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 12.07.2025.
//
import SwiftUI

struct DocumentListItem: View {
	let document: PDFModel
	
	var body: some View {
		HStack {
			Image(systemName: "doc.text.fill")
				.resizable()
				.scaledToFit()
				.frame(width: 30)
				.foregroundColor(.gray)
			
			VStack(alignment: .leading, spacing: 4) {
				Text(document.name)
					.font(.body)
				
				Text("\(String(format: "%.1f", document.size)) MB • \(document.dateModified.formatted(.dateTime.month().day().year()))")
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
