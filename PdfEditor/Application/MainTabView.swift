//
//  MainTabView.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 14.07.2025.
//

import SwiftUI

struct MainTabView: View {
	
	@EnvironmentObject private var router: AppRouter
	
    var body: some View {
		TabView(selection: $router.selectedTab) {
			NavigationStack(path: $router.homePath) {
				HomeView()
					.navigationDestination(for: Route.self) {
						router.view(for: $0)
					}
			}
			.tabItem {
				Image(systemName: "folder")
				Text("Home")
			}
			.tag(Tab.home)
			
			NavigationStack(path: $router.filesPath) {
				FilesView()
					.navigationDestination(for: Route.self) {
						router.view(for: $0)
					}
			}
			.tabItem {
				Image(systemName: "folder")
				Text("Files")
			}
			.tag(Tab.files)
			
		}
    }
}

#Preview {
    MainTabView()
}
