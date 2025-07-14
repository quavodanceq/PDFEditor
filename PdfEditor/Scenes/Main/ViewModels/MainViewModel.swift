import Foundation
import SwiftUI

final class MainViewModel: ObservableObject {
    
    struct State {
        var recentDocuments: [PDFDocument] = []
        var isLoading: Bool = false
    }
    
    @Published var state = State()
    
    func loadRecentDocuments() {
        state.isLoading = true
        // TODO: Implement loading logic
        state.isLoading = false
    }
}


