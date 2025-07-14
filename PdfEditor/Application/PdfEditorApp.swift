//
//  PdfEditorApp.swift
//  PdfEditor
//
//  Created by Куат Оралбеков on 12.07.2025.
//

import SwiftUI

@main
struct PdfEditorApp: App {
	
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RouterView()
        }
    }
}
