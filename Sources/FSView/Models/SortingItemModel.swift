//
//  SortItemModel.swift
//  FSView
//
//  Created by Esat Gözcü on 11.01.2025.
//

import Foundation

public struct SortingItemModel: Identifiable {
    public let id = UUID()
    public let title: String
    public var isSelected: Bool
    public var isPrimary: Bool
    public var isDefault: Bool
    
    public init(title: String,
                isSelected: Bool = false,
                isPrimary: Bool = false,
                isDefault: Bool = false) {
        self.title = title
        self.isSelected = isSelected
        self.isPrimary = isPrimary
        self.isDefault = isDefault
    }
}
