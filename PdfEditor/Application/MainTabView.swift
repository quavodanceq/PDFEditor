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
        ZStack(alignment: .bottom) {
            TabView(selection: $router.selectedTab) {
                NavigationStack(path: $router.homePath) {
                    HomeView()
                        .navigationDestination(for: Route.self) {
                            router.view(for: $0)
                        }
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(Tab.home)
                
                // Empty tab for center button
                Color.clear
                    .tabItem { Text("New") }
                
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
            .fullScreenCover(item: $router.fullScreenCover) { screen in
                router.fullScreenView(for: screen)
            }
            
            // Overlay New Button
            FloatingActionButton {
				router.presentFullScreen(screen: .documentCreation)
            }
            .offset(y: -15) // Changed from -5 to -15 to position it higher
           
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppRouter())
}
