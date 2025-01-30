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
    let config = FSMainConfig.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        updateDataBeforeLaunch()
    }
    
    //MARK: Update UI
    private func updateDataBeforeLaunch() {
        config.updateFsViewConfig { fsViewConfig in
            //fsViewConfig.spacing = 10
        }
        config.updateFsStickConfig { stickyConfig in
            //stickyConfig.dividerColor = .red
        }
    }
}
