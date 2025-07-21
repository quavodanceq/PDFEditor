//
//  DocumentDetailView.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 17.07.2025.
//

import SwiftUI

struct DocumentDetailView: View {
	
	@ObservedObject private var viewModel: DocumentDetailViewModel
    @State private var currentPage = 3
    @State private var totalPages = 12
    @Environment(\.colorScheme) private var colorScheme
    
    private var backgroundColor: Color {
        colorScheme == .dark ? .black : .white
    }
	
	init(viewModel: DocumentDetailViewModel) {
		self.viewModel = viewModel
	}
    
    var body: some View {
        VStack(spacing: 0) {
            // Navigation bar
            HStack {
                Button(action: {
					viewModel.backButtonTapped()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                }
                
				Text(viewModel.document.previewTitle)
                    .font(.headline)
                    .lineLimit(1)
                
                Spacer()
                
                Button(action: {
                    // Show more options
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.primary)
                        .rotationEffect(.degrees(90))
                }
            }
            .padding()
            .background(backgroundColor)

			PDFKitRepresentedView(document: viewModel.document)
			
            HStack(spacing: 32) {
                ToolbarButton(icon: "hand.raised.fill", action: {})
                ToolbarButton(icon: "pencil", action: {})
                ToolbarButton(icon: "link", action: {})
                ToolbarButton(icon: "textformat", action: {})
                ToolbarButton(icon: "eye", action: {})
                ToolbarButton(icon: "square.stack.3d.up", action: {})
            }
            .padding()
            .background(backgroundColor)
        }
        .navigationBarHidden(true)
    }
}

struct ToolbarButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.primary)
        }
    }
}

