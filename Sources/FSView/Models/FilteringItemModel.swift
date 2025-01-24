//
//  FilterItemModel.swift
//  FSView
//
//  Created by Esat Gözcü on 19.01.2025.
//

import SwiftUI

public struct FilteringItemModel: Identifiable {
    public let id = UUID()
    public let title: String
    public var isSelected: Bool
    public var isPrimary: Bool
    public var itemType: FilterButtonType
    
    public init(title: String,
                isSelected: Bool = false,
                isPrimary: Bool = false,
                type: FilterButtonType = .normal) {
        self.title = title
        self.isSelected = isSelected
        self.isPrimary = isPrimary
        self.itemType = type
    }
    
    public func getPrimaryToggleModel() -> [PrimaryToggleModel]? {
        switch itemType {
        case .toggle(let toggleModel):
            return toggleModel
        default:
            return nil
        }
    }
}

public struct PrimaryIconModel{
    public var icon: Image
    // Only available with systemImage
    public var iconForegroundColor: Color?
    // Background
    public var selectedBackgroundColor: Color
    public var backgroundColor: Color
    // Border
    public var selectedBorderColor: Color
    public var borderColor: Color
    
    public init(icon: Image,
                iconForegroundColor: Color? = nil,
                selectedBackgroundColor: Color = FSMainConfig.shared.primaryIconConfig.selectedBackgroundColor,
                backgroundColor: Color = FSMainConfig.shared.primaryIconConfig.backgroundColor,
                selectedBorderColor: Color = FSMainConfig.shared.primaryIconConfig.selectedBorderColor,
                borderColor: Color = FSMainConfig.shared.primaryIconConfig.borderColor
    ) {
        self.icon = icon
        self.iconForegroundColor = iconForegroundColor
        self.selectedBackgroundColor = selectedBackgroundColor
        self.backgroundColor = backgroundColor
        self.selectedBorderColor = selectedBorderColor
        self.borderColor = borderColor
    }
}

public struct PrimaryToggleModel: Identifiable{
    public let id = UUID()
    public let title: String
    public var isSelected: Bool
    
    public init(title: String,
                isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}

public enum FilterButtonType{
    case normal
    case toggle([PrimaryToggleModel])
    case withIcon(PrimaryIconModel)
    
    public var isNormal: Bool {
        if case .normal = self {
            return true
        }
        return false
    }
    
    public var isToggle: Bool {
        if case .toggle = self {
            return true
        }
        return false
    }
    
    public var isWithIcon: Bool {
        if case .withIcon = self {
            return true
        }
        return false
    }
}






