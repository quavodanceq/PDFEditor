//
//  ContentView.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 12.07.2025.
//

import SwiftUI

struct HomeView: View {
    
    // Placeholder data
    private let placeholderDocuments = [
		PDFDocument(id: UUID(), name: "Project Proposal", dateModified: Date(), size: 2.5),
		PDFDocument(id: UUID(), name: "Meeting Notes", dateModified: Date().addingTimeInterval(-86400), size: 1.2),
		PDFDocument(id: UUID(), name: "Contract Draft", dateModified: Date().addingTimeInterval(-172800), size: 3.8),
		PDFDocument(id: UUID(), name: "User Manual", dateModified: Date().addingTimeInterval(-259200), size: 5.1)
    ]
    
    public var body: some View {
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
							ForEach(placeholderDocuments) { document in
								RecentFileCard(document: document)
							}
						}
						.padding(.horizontal)
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
					
					ForEach(placeholderDocuments) { document in
						DocumentListItem(document: document)
						Divider()
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

#Preview {
    HomeView()
}
