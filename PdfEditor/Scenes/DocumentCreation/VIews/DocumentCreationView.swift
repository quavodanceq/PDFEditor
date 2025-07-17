//
//  DocumentCreationView.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 15.07.2025.
//

import SwiftUI

struct DocumentCreationView: View {
    
	@EnvironmentObject var router: AppRouter
	
    @State private var isFlashOn = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Camera preview would go here
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    // Top bar
                    HStack {
                        Button("Cancel") {
							router.dissmissFullScreen()
                        }
                        .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text("Scan Document")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        Spacer()
                    }
                    .padding()
                    
                    // Auto-detecting edges indicator
                    HStack {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .foregroundColor(.white)
                        Text("Auto-detecting edges")
                            .foregroundColor(.white)
                    }
                    .padding(8)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(20)
                    
                    // Scanning frame
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(Color.white.opacity(0.8), lineWidth: 2)
                            .frame(width: geometry.size.width - 40, height: geometry.size.width - 40)
                        
                        Text("Position document within frame")
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.vertical, 40)
                    
                    Spacer()
                    
                    // Bottom controls
                    HStack(spacing: 60) {
                        // Flash button
                        Button(action: {
                            isFlashOn.toggle()
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.2))
                                    .frame(width: 60, height: 60)
                                
                                Image(systemName: isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                            }
                        }
                        
                        // Capture button
                        Button(action: {
                            // Handle capture
                        }) {
                            Circle()
                                .stroke(Color.white, lineWidth: 4)
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 70, height: 70)
                                )
                        }
                        
                        // Import button
                        Button(action: {
                            // Handle import
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.2))
                                    .frame(width: 60, height: 60)
                                
                                Image(systemName: "photo")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                            }
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    DocumentCreationView()
}
