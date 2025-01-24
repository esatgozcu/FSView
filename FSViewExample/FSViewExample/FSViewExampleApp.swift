//
//  FSViewExampleApp.swift
//  FSViewExample
//
//  Created by Esat Gözcü on 23.01.2025.
//

import SwiftUI
import FSView

@main
struct FSViewApp: App {
    init() {
        updateDataBeforeLaunch()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    //MARK: Update UI
    private func updateDataBeforeLaunch() {
        FSMainConfig.shared.updateFsViewConfig { fsViewConfig in
            //fsViewConfig.spacing = 10
        }
        FSMainConfig.shared.updateFsStickConfig { stickyConfig in
            //stickyConfig.dividerColor = .red
        }
    }
}
