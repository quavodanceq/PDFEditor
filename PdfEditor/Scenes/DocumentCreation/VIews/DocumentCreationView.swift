//
//  DocumentCreationView.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 15.07.2025.
//

import SwiftUI

struct DocumentCreationView: View {
    @ObservedObject var viewModel: DocumentCreationViewModel
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    var body: some View {
        ZStack {
            // Document Camera Scanner
            VNDocumentCameraViewControllerRepresentable(viewModel: viewModel)
                .ignoresSafeArea()
            
            // Progress Overlay for Text Recognition
            if viewModel.isRecognizingText {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .animation(.easeInOut(duration: 0.3), value: viewModel.isRecognizingText)
                
                VStack {
                    GradientProgressView()
                }
                .transition(.scale.combined(with: .opacity))
            }
        }
        .onAppear {
            viewModel.setContext(managedObjectContext)
        }
    }
}

