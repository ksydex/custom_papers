//
//  CustomPapersApp.swift
//  CustomPapers
//
//  Created by Артем Лукьянов on 25.02.2023.
//

import SwiftUI

@main
struct CustomPapersApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
