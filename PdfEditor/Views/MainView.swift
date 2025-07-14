//
//  ContentView.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 12.07.2025.
//

import SwiftUI

struct MainView: View {
    // Sample data
    let recentFiles: [PDFDocument] = [
        PDFDocument(name: "Project Report.pdf", modifiedDate: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, size: 2.5),
        PDFDocument(name: "Contract_v2.pdf", modifiedDate: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, size: 1.8),
        PDFDocument(name: "Invoice_2025.pdf", modifiedDate: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, size: 1.2)
    ]
    
    let allDocuments: [PDFDocument] = [
        PDFDocument(name: "Annual Report 2025.pdf", modifiedDate: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, size: 12.5),
        PDFDocument(name: "Meeting Notes.pdf", modifiedDate: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, size: 3.2),
        PDFDocument(name: "Product Manual.pdf", modifiedDate: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, size: 8.7),
        PDFDocument(name: "Financial Statement.pdf", modifiedDate: Calendar.current.date(byAdding: .day, value: -9, to: Date())!, size: 5.1)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Recent Files Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Recent Files")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                            Button("See All") {
                                // Action
                            }
                            .foregroundColor(.blue)
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(recentFiles) { document in
                                    RecentFileCard(document: document)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // All Documents Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("All Documents")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                            
                            Menu {
                                Button("Name", action: {})
                                Button("Date", action: {})
                                Button("Size", action: {})
                            } label: {
                                Image(systemName: "arrow.up.arrow.down")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        ForEach(allDocuments) { document in
                            DocumentListItem(document: document)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .navigationTitle("PDF Editor")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button {
                        // Search action
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
                
                ToolbarItem(placement: .automatic) {
                    Button {
                        // More options
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
        }
    }
}

struct RecentFileCard: View {
    let document: PDFDocument
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 160, height: 200)
                .overlay(
                    Image(systemName: "doc.text.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                        .foregroundColor(.gray)
                )
            
            Text(document.name)
                .font(.subheadline)
                .lineLimit(1)
            
            Text("Modified: \(document.modifiedDate.formatted(.dateTime.month().day().year()))")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 160)
    }
}

struct DocumentListItem: View {
    let document: PDFDocument
    
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
                
                Text("\(String(format: "%.1f", document.size)) MB • \(document.modifiedDate.formatted(.dateTime.month().day().year()))")
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

#Preview {
    MainView()
}
