//
//  ContentView.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 12.07.2025.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject private var router: AppRouter
    @StateObject private var viewModel: HomeViewModel
    
    init() {
        
        self._viewModel = StateObject(wrappedValue: HomeViewModel(context: PersistenceController.shared.container.viewContext))
    }
    
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

						}
						.foregroundColor(.blue)
					}
					
					if viewModel.state.isLoading {
						ProgressView()
							.frame(maxWidth: .infinity, alignment: .center)
							.padding()
					} else if viewModel.state.recentDocuments.isEmpty {
						Text("No recent files")
							.foregroundColor(.gray)
							.frame(maxWidth: .infinity, alignment: .center)
							.padding()
					} else {
						ScrollView(.horizontal, showsIndicators: false) {
							HStack(spacing: 15) {
								ForEach(viewModel.state.recentDocuments) { document in
									RecentFileCard(document: document)
								}
							}
							.padding(.horizontal)
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
					
					if viewModel.state.isLoading {
						ProgressView()
							.frame(maxWidth: .infinity, alignment: .center)
							.padding()
					} else if viewModel.state.documents.isEmpty {
						VStack(spacing: 12) {
							Image(systemName: "doc.text")
								.font(.system(size: 50))
								.foregroundColor(.gray)
							Text("No documents yet")
								.font(.headline)
								.foregroundColor(.gray)
							Text("Create your first PDF document")
								.font(.subheadline)
								.foregroundColor(.gray)
						}
						.frame(maxWidth: .infinity, alignment: .center)
						.padding()
					} else {
						ForEach(viewModel.state.documents) { document in
							DocumentListItem(document: document)
								.onTapGesture {
									router.navigate(to: .documentDetail(document: document))
								}
								.swipeActions(edge: .trailing) {
									Button("Delete", role: .destructive) {
										viewModel.deleteDocument(document)
									}
								}
							if document.id != viewModel.state.documents.last?.id {
								Divider()
							}
						}
					}
				}
				.padding(.horizontal)
			}
			.padding(.top)
			.padding(.bottom, 100)
		}
		.navigationTitle("PDF Editor")
		.onAppear {
			viewModel.updateContext(context)
			viewModel.loadDocuments()
		}
		.refreshable {
			viewModel.loadDocuments()
		}
		.toolbar {
			ToolbarItem(placement: .automatic) {
				Button {
					
				} label: {
					Image(systemName: "magnifyingglass")
				}
			}
			
			ToolbarItem(placement: .automatic) {
				Button {
					
				} label: {
					Image(systemName: "ellipsis")
				}
			}
		}
		.alert("Ошибка удаления", isPresented: $viewModel.state.showDeleteError) {
			Button("OK") {
				viewModel.dismissDeleteError()
			}
		} message: {
			Text(viewModel.state.deleteError ?? "")
		}
	}
}

#Preview {
    HomeView()
		.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
