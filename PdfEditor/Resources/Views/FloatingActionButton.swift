//
//  FloatingActionButton.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 15.07.2025.
//

import SwiftUI

struct FloatingActionButton: View {
	let action: () -> Void
	let icon: String
	let backgroundColor: Color
	let iconColor: Color
	let size: CGFloat
	
	init(
		icon: String = "plus",
		backgroundColor: Color = .blue,
		iconColor: Color = .white,
		size: CGFloat = 60,
		action: @escaping () -> Void
	) {
		self.icon = icon
		self.backgroundColor = backgroundColor
		self.iconColor = iconColor
		self.size = size
		self.action = action
	}
	
	var body: some View {
		Button(action: action) {
			ZStack {
				Circle()
					.fill(backgroundColor)
					.frame(width: size, height: size)
					.shadow(radius: 5)
				
				Image(systemName: icon)
					.font(.system(size: size/2))
					.foregroundStyle(iconColor)
			}
		}
	}
}
