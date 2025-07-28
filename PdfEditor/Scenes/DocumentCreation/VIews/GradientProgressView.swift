//
//  GradientProgressView.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 28.07.2025.
//
import SwiftUI

struct GradientProgressView: View {
	@State private var rotation: Double = 0
	
	var body: some View {
		Circle()
			.trim(from: 0, to: 0.8)
			.stroke(
				AngularGradient(
					gradient: Gradient(colors: [
						Color.clear,
						Color.blue,
						Color.cyan
					]),
					center: .center,
					startAngle: .degrees(0),
					endAngle: .degrees(288)
				),
				style: StrokeStyle(lineWidth: 6, lineCap: .butt)
			)
			.frame(width: 40, height: 40)
			.rotationEffect(.degrees(rotation))
			.onAppear {
				withAnimation(.linear(duration: 1.0).repeatForever(autoreverses: false)) {
					rotation = 360
				}
			}
	}
}

#Preview {
	GradientProgressView()
}

