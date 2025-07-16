import SwiftUI
import Combine

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
		
    }
    
    func navigateToRoot() {
		
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
				DocumentCreationView()
		}
	}
}

enum FullScreenCover: Identifiable {
	
	var id: Self { self }
	
	case documentCreation
}

enum Route: Hashable {
	case main
}

enum Tab {
	case home
	case files
}

