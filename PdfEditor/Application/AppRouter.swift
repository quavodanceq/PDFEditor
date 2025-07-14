import SwiftUI
import Combine

class AppRouter: ObservableObject {
    
    @Published var path: NavigationPath = NavigationPath()
	
	@ViewBuilder
	func view(for route: Route) -> some View {
		switch route {
			case .main:
			MainView()
		}
		
    }
    
    func navigate(to route: Route) {
		path.append(route)
    }
    
    func navigateBack() {
		path.removeLast()
    }
    
    func navigateToRoot() {
		path.removeLast(path.count)
    }
} 

enum Route: Hashable {
	case main
}

