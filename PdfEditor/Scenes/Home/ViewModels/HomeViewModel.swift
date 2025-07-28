import Foundation
import SwiftUI
import CoreData

@MainActor
class HomeViewModel: ObservableObject {
    
    struct State {
        var documents: [PDFFile] = []
        var recentDocuments: [PDFFile] = []
        var isLoading: Bool = false
        var deleteError: String? = nil
        var showDeleteError: Bool = false
    }
    
    @Published var state = State()
    private var repository: PDFRepository
    
    init(context: NSManagedObjectContext) {
        self.repository = PDFRepository(context: context)
    }
    
    func updateContext(_ context: NSManagedObjectContext) {
        self.repository = PDFRepository(context: context)
    }
    
    func loadDocuments() {
        state.isLoading = true
        
        Task {
            let allDocuments = repository.fetchAll()
            self.state.documents = allDocuments
            self.state.recentDocuments = Array(allDocuments.prefix(4))
            self.state.isLoading = false
        }
    }
    
    func deleteDocument(_ document: PDFFile) {
        let result = repository.delete(document)
        
        switch result {
        case .success:
            // Успешное удаление - обновляем список документов
            loadDocuments()
            
        case .failure(let error):
            // Ошибка удаления - показываем сообщение пользователю
            state.deleteError = error.localizedDescription
            state.showDeleteError = true
            
            // В случае частичной ошибки все равно обновляем список
            // чтобы синхронизировать состояние UI с реальным состоянием данных
            if case .partialFailure(_) = error {
                loadDocuments()
            }
        }
    }
    
    func dismissDeleteError() {
        state.deleteError = nil
        state.showDeleteError = false
    }
}


