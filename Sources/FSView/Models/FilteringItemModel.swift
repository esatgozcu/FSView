//
//  FilterItemModel.swift
//  FSView
//
//  Created by Esat Gözcü on 19.01.2025.
//

import SwiftUI

struct FilteringItemModel: Identifiable {
    let id = UUID()
    let title: String
    var isSelected: Bool = false
    var isPrimary: Bool = false
    var isOpened: Bool = false
    var type: FilterButtonType = .normal
}

struct PrimaryIconModel{
    var icon: Image
    // Only available with systemImage
    var iconForegroundColor: Color?
    // Background
    var selectedBackgroundColor: Color = FSMainConfig.shared.primaryIconConfig.selectedBackgroundColor
    var backgroundColor: Color = FSMainConfig.shared.primaryIconConfig.backgroundColor
    // Border
    var selectedBorderColor: Color = FSMainConfig.shared.primaryIconConfig.selectedBorderColor
    var borderColor: Color = FSMainConfig.shared.primaryIconConfig.borderColor
}

enum FilterButtonType{
    case normal
    case toggle
    case withIcon(PrimaryIconModel)
}






