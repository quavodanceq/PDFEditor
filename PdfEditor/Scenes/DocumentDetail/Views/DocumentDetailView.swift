//
//  DocumentDetailView.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 17.07.2025.
//

import SwiftUI

struct DocumentDetailView: View {
	@StateObject private var viewModel: DocumentCreationViewModel
    @State private var currentPage = 3
    @State private var totalPages = 12
    @Environment(\.colorScheme) private var colorScheme
    
    var documentTitle: String
    
    private var backgroundColor: Color {
        colorScheme == .dark ? .black : .white
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Navigation bar
            HStack {
                Button(action: {
                    
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                }
                
                Text(documentTitle)
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
            
            // PDF content
//            ScrollView {
//                VStack(spacing: 16) {
//                    // Page content preview
//                    VStack(spacing: 8) {
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(Color.gray.opacity(0.1))
//                            .frame(height: 200)
//                            .overlay(
//                                Text("Page content")
//                                    .foregroundColor(.gray)
//                            )
//                        
//                        // Placeholder text lines
//                        ForEach(0..<5) { _ in
//                            RoundedRectangle(cornerRadius: 4)
//                                .fill(Color.gray.opacity(0.1))
//                                .frame(height: 8)
//                        }
//                    }
//                    .padding()
//                    
//                    // Chart data preview
//                    VStack(spacing: 8) {
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(Color.gray.opacity(0.1))
//                            .frame(height: 150)
//                            .overlay(
//                                Text("Chart data")
//                                    .foregroundColor(.gray)
//                            )
//                        
//                        // Placeholder chart data lines
//                        ForEach(0..<4) { _ in
//                            RoundedRectangle(cornerRadius: 4)
//                                .fill(Color.gray.opacity(0.1))
//                                .frame(height: 8)
//                        }
//                    }
//                    .padding()
//                    
//                    // Page counter
//                    HStack {
//                        Spacer()
//                        Text("\(currentPage) / \(totalPages)")
//                            .font(.subheadline)
//                            .foregroundColor(.white)
//                            .padding(.horizontal, 12)
//                            .padding(.vertical, 6)
//                            .background(Color.black.opacity(0.6))
//                            .cornerRadius(16)
//                        Spacer()
//                    }
//                    .padding(.vertical)
//                }
//            }

            
            // Bottom toolbar
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

#Preview {
    DocumentDetailView(documentTitle: "Annual Report 2025.pdf")
        .environmentObject(AppRouter())
}
