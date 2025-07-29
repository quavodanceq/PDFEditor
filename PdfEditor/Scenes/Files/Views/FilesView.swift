//
//  FilesView.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 14.07.2025.
//
import SwiftUI


struct FilesView: View {
    @State private var searchText = ""
    
    private let storageLocations = [
        ("Internal Storage", "folder.fill"),
        ("iCloud", "apple.logo"),
        ("Drive", "arrow.triangle.branch"),
        ("dropbox", "square.fill")
    ]
    
    private let recentFiles = [
        PDFFile(id: UUID(), name: "Project Proposal Final", fileName: "Project_Proposal_Final.pdf", createdAt: Date(), thumbnailFileName: "Project_Proposal_Final_thumbnail.jpg"),
        PDFFile(id: UUID(), name: "Financial Report Q2", fileName: "Financial_Report_Q2.pdf", createdAt: Date().addingTimeInterval(-4 * 24 * 3600), thumbnailFileName: "Financial_Report_Q2_thumbnail.jpg"),
        PDFFile(id: UUID(), name: "User Manual v1.2", fileName: "User_Manual_v1.2.pdf", createdAt: Date().addingTimeInterval(-9 * 24 * 3600), thumbnailFileName: "User_Manual_v1.2_thumbnail.jpg"),
        PDFFile(id: UUID(), name: "Contract Agreement", fileName: "Contract_Agreement.pdf", createdAt: Date().addingTimeInterval(-14 * 24 * 3600), thumbnailFileName: "Contract_Agreement_thumbnail.jpg")
    ]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search files...", text: $searchText)
                    }
                    .padding(12)
                    .background(Color(uiColor: .systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // Browse Locations
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Browse Locations")
                            .font(.headline)
                        
                        HStack(spacing: 20) {
                            ForEach(storageLocations, id: \.0) { location in
                                StorageLocationButton(
                                    title: location.0,
                                    iconName: location.1
                                ) {
                                    handleStorageLocationTap(location.0)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Recently Downloaded
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Recently Downloaded")
                                .font(.headline)
                            Spacer()
                            Button("See All") {
                                // Action
                            }
                            .foregroundColor(.blue)
                        }
                        
                        VStack(spacing: 20) {
                            ForEach(recentFiles) { file in
                                HStack(spacing: 12) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(uiColor: .systemGray6))
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            Image(systemName: "doc")
                                                .foregroundColor(.gray)
                                        )
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(file.name)
                                            .font(.subheadline)
                                        
                                        Text("\(String(format: "%.1f", file.fileSize)) MB • Modified \(file.createdAt.formatted(.dateTime.month().day().year()))")
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
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Files")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // More options
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
    }
    
    private func handleStorageLocationTap(_ location: String) {
        // Handle storage location selection
        print("Selected storage location: \(location)")
    }
}

#Preview {
    NavigationStack {
        FilesView()
    }
}
