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
        PDFModel(id: UUID(), name: "Project_Proposal_Final.pdf", dateModified: Date(), size: 2.4),
        PDFModel(id: UUID(), name: "Financial_Report_Q2.pdf", dateModified: Date().addingTimeInterval(-4 * 24 * 3600), size: 5.7),
        PDFModel(id: UUID(), name: "User_Manual_v1.2.pdf", dateModified: Date().addingTimeInterval(-9 * 24 * 3600), size: 8.1),
        PDFModel(id: UUID(), name: "Contract_Agreement.pdf", dateModified: Date().addingTimeInterval(-14 * 24 * 3600), size: 1.2)
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
                                        
                                        Text("\(String(format: "%.1f", file.size)) MB • Modified \(file.dateModified.formatted(.dateTime.month().day().year()))")
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
