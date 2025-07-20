import SwiftUI
import Combine
import PDFKit

class AppRouter: ObservableObject {
    
    @Published var selectedTab: Tab = .home
    
    @Published var homePath: NavigationPath = NavigationPath()
    
    @Published var filesPath: NavigationPath = NavigationPath()
    
    @Published var fullScreenCover: FullScreenCover?
    
    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .main:
            HomeView()
        case .documentDetail(let document):
			DocumentDetailView(viewModel: DocumentDetailViewModel(document: document))
        }
    }
    
    func navigate(to route: Route) {
        switch selectedTab {
        case .home:
            homePath.append(route)
        case .files:
            filesPath.append(route)
        }
    }
    
    func navigateBack() {
		switch selectedTab {
		case .home:
			homePath.removeLast()
		case .files:
			filesPath.removeLast()
		}
    }
    
    func navigateToRoot() {
		switch selectedTab {
		case .home:
			homePath = NavigationPath()
		case .files:
			filesPath = NavigationPath()
		}
    }
    
    func presentFullScreen(screen: FullScreenCover) {
        fullScreenCover = screen
    }
    
    func dissmissFullScreen() {
        fullScreenCover = nil
    }
    
    @ViewBuilder
    func fullScreenView(for screen: FullScreenCover) -> some View {
        switch screen {
        case .documentCreation:
        VNDocumentCameraViewControllerRepresentable(viewModel: DocumentCreationViewModel(router: self))
        }
    }
}

enum FullScreenCover: Identifiable {
    
    var id: Self { self }
    
    case documentCreation
}

enum Route: Hashable {
    case main
    case documentDetail(document: PDFDocument)
}

enum Tab {
    case home
    case files
}

