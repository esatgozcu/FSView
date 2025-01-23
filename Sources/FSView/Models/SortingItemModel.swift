//
//  SortItemModel.swift
//  FSView
//
//  Created by Esat Gözcü on 11.01.2025.
//

import Foundation

struct SortingItemModel: Identifiable {
    let id = UUID()
    let title: String
    var isSelected: Bool = false
    var isPrimary: Bool = false
    var isDefault: Bool = false
}
