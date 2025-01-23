//
//  FSMainConfig.swift
//  FSView
//
//  Created by Esat Gözcü on 19.01.2025.
//

import SwiftUI

// MARK: - Main Configuration
final class FSMainConfig {
    static let shared = FSMainConfig()
    
    private(set) var fsViewConfig: FSViewConfig
    private(set) var stickyConfig: FSStickyConfig
    private(set) var primaryConfig: FSPrimaryConfig
    private(set) var primaryToggleConfig: FSPrimaryToggleConfig
    private(set) var primaryIconConfig: FSPrimaryIconConfig
    private(set) var primarySortingConfig: FSPrimarySortingConfig
    private(set) var stickyFilteringConfig: FSStickyFilteringConfig
    private(set) var stickySortingConfig: FSStickySortingConfig
    
    private init() {
        self.fsViewConfig = FSViewConfig()
        self.stickyConfig = FSStickyConfig()
        self.primaryConfig = FSPrimaryConfig()
        self.primaryToggleConfig = FSPrimaryToggleConfig()
        self.primaryIconConfig = FSPrimaryIconConfig()
        self.primarySortingConfig = FSPrimarySortingConfig()
        self.stickyFilteringConfig = FSStickyFilteringConfig()
        self.stickySortingConfig = FSStickySortingConfig()
    }
    func updateFsViewConfig(_ updates: (FSViewConfig) -> Void) {
        updates(fsViewConfig)
    }
    func updateFsStickConfig(_ updates: (FSStickyConfig) -> Void) {
        updates(stickyConfig)
    }
    func updateFsPrimaryConfig(_ updates: (FSPrimaryConfig) -> Void) {
        updates(primaryConfig)
    }
    func updateFsPrimaryToggleConfig(_ updates: (FSPrimaryToggleConfig) -> Void) {
        updates(primaryToggleConfig)
    }
    func updateFsPrimaryIconConfig(_ updates: (FSPrimaryIconConfig) -> Void) {
        updates(primaryIconConfig)
    }
    func updateFsPrimarySortingConfig(_ updates: (FSPrimarySortingConfig) -> Void) {
        updates(primarySortingConfig)
    }
    func updateFsStickyFilteringConfig(_ updates: (FSStickyFilteringConfig) -> Void) {
        updates(stickyFilteringConfig)
    }
    func updateFsStickySortingConfig(_ updates: (FSStickySortingConfig) -> Void) {
        updates(stickySortingConfig)
    }
}

// MARK: - FSView Configuration
final class FSViewConfig {
    var spacing: CGFloat = 5
    var scrollBackground: Color = Color(.systemBackground)

    fileprivate init() {}
}

// MARK: - FSSticky Configuration
final class FSStickyConfig {
    // Background configurations
    var backgroundColor: Color = Color(.systemBackground)
    // Divider
    var dividerHeight: CGFloat = 36
    // Size configurations
    var height: CGFloat = 40
    var padding: CGFloat = 10
    var spacing: CGFloat = 10
    
    fileprivate init() {}
}

// MARK: - FSPrimary Configuration
final class FSPrimaryConfig {
    // Background configurations
    var backgroundColor: Color = Color(.systemBackground)
    var selectedBackgroundColor: Color = Color.cyan.opacity(0.05)
    // Text configurations
    var textColor: Color = .primary
    var selectedTextColor: Color = .blue
    var textFont: Font = .system(size: 14, weight: .medium)
    // Border configurations
    var borderColor: Color = Color.gray.opacity(0.8)
    var selectedBorderColor: Color = Color.cyan
    var borderWidth: CGFloat = 0.7
    var cornerRadius: CGFloat = 18
    // Size configurations
    var height: CGFloat = 36
    var padding: CGFloat = 12
    
    fileprivate init() {}
}

// MARK: - FSPrimary Configuration
final class FSPrimaryToggleConfig {
    // Background configurations
    var backgroundColor: Color = Color(.systemBackground)
    var selectedBackgroundColor: Color = Color(.systemBackground)
    // Text configurations
    var textColor: Color = .primary
    var selectedTextColor: Color = .primary
    var textFont: Font = .system(size: 14, weight: .medium)
    // Border configurations
    var borderColor: Color = .gray.opacity(0.8)
    var selectedBorderColor: Color = .orange
    var borderWidth: CGFloat = 0.7
    var cornerRadius: CGFloat = 18
    // Size configurations
    var height: CGFloat = 36
    var padding: CGFloat = 12
    var spacing: CGFloat = 12
    // Chevron image
    var imageSystemName: String = "chevron.up"
    var imageSize: CGSize = CGSize(width: 15, height: 15)
    
    fileprivate init() {}
}

// MARK: - FSPrimaryWithIcon Configuration
final class FSPrimaryIconConfig {
    // Text configurations
    var textColor: Color = .primary
    var selectedTextColor: Color = .primary
    var textFont: Font = .system(size: 14, weight: .medium)
    // Border configurations
    var borderWidth: CGFloat = 0.7
    var cornerRadius: CGFloat = 18
    // Size configurations
    var height: CGFloat = 36
    var padding: CGFloat = 12
    var spacing: CGFloat = 6
    // Image size
    var imageSize: CGSize = CGSize(width: 15, height: 15)
    // Background
    var selectedBackgroundColor: Color = Color.cyan.opacity(0.05)
    var backgroundColor: Color = Color(.systemBackground)
    // Border
    var selectedBorderColor: Color = Color.cyan
    var borderColor: Color = .gray.opacity(0.8)
    
    fileprivate init() {}
}

// MARK: - FSPrimarySorting Configuration
final class FSPrimarySortingConfig {
    // Background configurations
    var backgroundColor: Color = Color(.systemBackground)
    var selectedBackgroundColor: Color = Color(.systemBackground)
    // Text configurations
    var textColor: Color = .primary
    var selectedTextColor: Color = .primary
    var textFont: Font = .system(size: 14, weight: .medium)
    // Border configurations
    var borderColor: Color = .gray.opacity(0.8)
    var selectedBorderColor: Color = Color.orange
    var borderWidth: CGFloat = 0.7
    var cornerRadius: CGFloat = 18
    // Size configurations
    var height: CGFloat = 36
    var padding: CGFloat = 12
    
    fileprivate init() {}
}


// MARK: - FSStickySorting Configuration
final class FSStickySortingConfig {
    // Text configurations
    var text: String = "Sorting"
    var textColor: Color = .primary
    var textFont: Font = .system(size: 14, weight: .medium)
    // Background configurations
    var backgroundColor: Color = Color(.systemBackground)
    var selectedBackgroundColor: Color = Color(.systemBackground)
    // Image configurations
    var image: Image = Image(systemName: "arrow.up.arrow.down")
    /// Only available with systemImage
    var systemImageForegroundColor: Color = .orange
    var imageSize: CGSize = CGSize(width: 15, height: 15)
    var scrolledImageSize: CGSize = CGSize(width: 17, height: 17)
    // Border configurations
    var borderColor: Color = .gray.opacity(0.8)
    var selectedBorderColor: Color = .orange
    var borderWidth: CGFloat = 0.9
    var cornerRadius: CGFloat = 18
    // Size configurations
    var minWidth: CGFloat = 50
    var defaultWidth: CGFloat = 100
    var height: CGFloat = 36
    
    fileprivate init() {}
}

// MARK: - FSStickyFiltering Configuration
final class FSStickyFilteringConfig {
    // Text configurations
    var text: String = "Filtering"
    var textColor: Color = .primary
    var selectedTextColor: Color = .primary
    var textFont: Font = .system(size: 14, weight: .medium)
    // Background configurations
    var backgroundColor: Color = Color(.systemBackground)
    var selectedBackgroundColor: Color = .orange.opacity(0.1)
    // Icon configurations
    var image: Image = Image(systemName: "line.3.horizontal.decrease")
    /// Only available with systemImage
    var systemImageForegroundColor: Color = .orange
    var imageSize: CGSize = CGSize(width: 15, height: 15)
    var scrolledImageSize: CGSize = CGSize(width: 17, height: 17)
    // Border configurations
    var borderColor: Color = .gray.opacity(0.8)
    var selectedBorderColor: Color = .orange
    var borderWidth: CGFloat = 0.9
    var cornerRadius: CGFloat = 18
    // Badge configurations
    var badgeTextColor: Color = .white
    var badgeBackgroundColor: Color = .orange
    var badgeFont: Font = .system(size: 9, weight: .medium)
    var badgePadding: CGFloat = 5.0
    /// The reference point is the top-right corner of the rectangle.
    var badgeOffset: CGPoint = CGPoint(x: -6, y: -6)
    // Size configurations
    var minWidth: CGFloat = 50
    var defaultWidth: CGFloat = 100
    var height: CGFloat = 36
    
    fileprivate init() {}
}
