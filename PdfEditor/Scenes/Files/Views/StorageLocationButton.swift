//
//  S.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 14.07.2025.
//

import SwiftUI

struct StorageLocationButton: View {
	let title: String
	let iconName: String
	let action: () -> Void
	
	var body: some View {
		Button(action: action) {
			VStack {
				RoundedRectangle(cornerRadius: 12)
					.fill(Color(uiColor: .systemGray6))
					.frame(width: 70, height: 70)
					.overlay(
						Image(systemName: iconName)
							.font(.system(size: 24))
							.foregroundColor(.gray)
					)
				
				Text(title)
					.font(.caption)
					.foregroundColor(.primary)
			}
		}
		.buttonStyle(PlainButtonStyle())
		.accessibilityLabel("\(title) storage location")
	}
}
