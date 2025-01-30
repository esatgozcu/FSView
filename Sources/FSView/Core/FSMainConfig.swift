//
//  FSMainConfig.swift
//  FSView
//
//  Created by Esat Gözcü on 19.01.2025.
//

import SwiftUI

// MARK: - Main Configuration
public final class FSMainConfig {
    public static let shared = FSMainConfig()
    
    public private(set) var fsViewConfig: FSViewConfig
    public private(set) var stickyConfig: FSStickyConfig
    public private(set) var primaryConfig: FSPrimaryConfig
    public private(set) var primaryToggleConfig: FSPrimaryToggleConfig
    public private(set) var primaryIconConfig: FSPrimaryIconConfig
    public private(set) var primarySortingConfig: FSPrimarySortingConfig
    public private(set) var stickyFilteringConfig: FSStickyFilteringConfig
    public private(set) var stickySortingConfig: FSStickySortingConfig
    
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
    public func updateFsViewConfig(_ updates: (FSViewConfig) -> Void) {
        updates(fsViewConfig)
    }
    public func updateFsStickConfig(_ updates: (FSStickyConfig) -> Void) {
        updates(stickyConfig)
    }
    public func updateFsPrimaryConfig(_ updates: (FSPrimaryConfig) -> Void) {
        updates(primaryConfig)
    }
    public func updateFsPrimaryToggleConfig(_ updates: (FSPrimaryToggleConfig) -> Void) {
        updates(primaryToggleConfig)
    }
    public func updateFsPrimaryIconConfig(_ updates: (FSPrimaryIconConfig) -> Void) {
        updates(primaryIconConfig)
    }
    public func updateFsPrimarySortingConfig(_ updates: (FSPrimarySortingConfig) -> Void) {
        updates(primarySortingConfig)
    }
    public func updateFsStickyFilteringConfig(_ updates: (FSStickyFilteringConfig) -> Void) {
        updates(stickyFilteringConfig)
    }
    public func updateFsStickySortingConfig(_ updates: (FSStickySortingConfig) -> Void) {
        updates(stickySortingConfig)
    }
}

// MARK: - FSView Configuration
public final class FSViewConfig {
    public var spacing: CGFloat = 5
    public var scrollBackground: Color = Color(.systemBackground)

    fileprivate init() {}
}

// MARK: - FSSticky Configuration
public final class FSStickyConfig {
    // Background configurations
    public var backgroundColor: Color = Color(.systemBackground)
    // Divider
    public var dividerHeight: CGFloat = 36
    public var dividerColor: Color = Color(UIColor.separator)
    // Size configurations
    public var height: CGFloat = 40
    public var padding: CGFloat = 10
    public var spacing: CGFloat = 10
    
    fileprivate init() {}
}

// MARK: - FSStickyFiltering Configuration
public final class FSStickyFilteringConfig {
    // Text configurations
    public var text: String = "Filtering"
    public var textColor: Color = .primary
    public var selectedTextColor: Color = .primary
    public var textFont: Font = .system(size: 14, weight: .medium)
    // Background configurations
    public var backgroundColor: Color = Color(.systemBackground)
    public var selectedBackgroundColor: Color = .orange.opacity(0.1)
    // Icon configurations
    public var image: Image = Image(systemName: "line.3.horizontal.decrease")
    /// Only available with systemImage
    public var systemImageForegroundColor: Color = .orange
    public var imageSize: CGSize = CGSize(width: 15, height: 15)
    public var scrolledImageSize: CGSize = CGSize(width: 17, height: 17)
    // Border configurations
    public var borderColor: Color = .gray.opacity(0.8)
    public var selectedBorderColor: Color = .orange
    public var borderWidth: CGFloat = 0.9
    public var cornerRadius: CGFloat = 18
    // Badge configurations
    public var badgeTextColor: Color = .white
    public var badgeBackgroundColor: Color = .orange
    public var badgeFont: Font = .system(size: 9, weight: .medium)
    public var badgePadding: CGFloat = 5.0
    /// The reference point is the top-right corner of the rectangle.
    public var badgeOffset: CGPoint = CGPoint(x: -6, y: -6)
    // Size configurations
    public var minWidth: CGFloat = 50
    public var defaultWidth: CGFloat = 100
    public var height: CGFloat = 36
    
    fileprivate init() {}
}

// MARK: - FSStickySorting Configuration
public final class FSStickySortingConfig {
    // Text configurations
    public var text: String = "Sorting"
    public var textColor: Color = .primary
    public var textFont: Font = .system(size: 14, weight: .medium)
    // Background configurations
    public var backgroundColor: Color = Color(.systemBackground)
    public var selectedBackgroundColor: Color = Color(.systemBackground)
    // Image configurations
    public var image: Image = Image(systemName: "arrow.up.arrow.down")
    /// Only available with systemImage
    public var systemImageForegroundColor: Color = .orange
    public var imageSize: CGSize = CGSize(width: 15, height: 15)
    public var scrolledImageSize: CGSize = CGSize(width: 17, height: 17)
    // Border configurations
    public var borderColor: Color = .gray.opacity(0.8)
    public var selectedBorderColor: Color = .orange
    public var borderWidth: CGFloat = 0.9
    public var cornerRadius: CGFloat = 18
    // Size configurations
    public var minWidth: CGFloat = 50
    public var defaultWidth: CGFloat = 100
    public var height: CGFloat = 36
    
    fileprivate init() {}
}

// MARK: - FSPrimary Configuration
public final class FSPrimaryConfig {
    // Background configurations
    public var backgroundColor: Color = Color(.systemBackground)
    public var selectedBackgroundColor: Color = Color.cyan.opacity(0.05)
    // Text configurations
    public var textColor: Color = .primary
    public var selectedTextColor: Color = .blue
    public var textFont: Font = .system(size: 14, weight: .medium)
    // Border configurations
    public var borderColor: Color = Color.gray.opacity(0.8)
    public var selectedBorderColor: Color = Color.cyan
    public var borderWidth: CGFloat = 0.7
    public var cornerRadius: CGFloat = 18
    // Size configurations
    public var height: CGFloat = 36
    public var padding: CGFloat = 12
    
    fileprivate init() {}
}

// MARK: - FSPrimary Configuration
public final class FSPrimaryToggleConfig {
    // Background configurations
    public var backgroundColor: Color = Color(.systemBackground)
    public var selectedBackgroundColor: Color = Color(.systemBackground)
    // Text configurations
    public var textColor: Color = .primary
    public var selectedTextColor: Color = .primary
    public var textFont: Font = .system(size: 14, weight: .medium)
    // Border configurations
    public var borderColor: Color = .gray.opacity(0.8)
    public var selectedBorderColor: Color = .orange
    public var borderWidth: CGFloat = 0.7
    public var cornerRadius: CGFloat = 18
    // Size configurations
    public var height: CGFloat = 36
    public var padding: CGFloat = 12
    public var spacing: CGFloat = 12
    // Chevron image
    public var imageSystemName: String = "chevron.up"
    public var imageSize: CGSize = CGSize(width: 15, height: 15)
    
    fileprivate init() {}
}

// MARK: - FSPrimaryWithIcon Configuration
public final class FSPrimaryIconConfig {
    // Text configurations
    public var textColor: Color = .primary
    public var selectedTextColor: Color = .primary
    public var textFont: Font = .system(size: 14, weight: .medium)
    // Border configurations
    public var borderWidth: CGFloat = 0.7
    public var cornerRadius: CGFloat = 18
    // Size configurations
    public var height: CGFloat = 36
    public var padding: CGFloat = 12
    public var spacing: CGFloat = 6
    // Image size
    public var imageSize: CGSize = CGSize(width: 15, height: 15)
    // Background
    public var selectedBackgroundColor: Color = Color.cyan.opacity(0.1)
    public var backgroundColor: Color = Color(.systemBackground)
    // Border
    public var selectedBorderColor: Color = Color.cyan
    public var borderColor: Color = .gray.opacity(0.8)
    
    fileprivate init() {}
}

// MARK: - FSPrimarySorting Configuration
public final class FSPrimarySortingConfig {
    // Background configurations
    public var backgroundColor: Color = Color(.systemBackground)
    public var selectedBackgroundColor: Color = Color(.systemBackground)
    // Text configurations
    public var textColor: Color = .primary
    public var selectedTextColor: Color = .primary
    public var textFont: Font = .system(size: 14, weight: .medium)
    // Border configurations
    public var borderColor: Color = .gray.opacity(0.8)
    public var selectedBorderColor: Color = Color.orange
    public var borderWidth: CGFloat = 0.7
    public var cornerRadius: CGFloat = 18
    // Size configurations
    public var height: CGFloat = 36
    public var padding: CGFloat = 12
    
    fileprivate init() {}
}
