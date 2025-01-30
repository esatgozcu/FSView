//
//  FSPrimarySortingView.swift
//  FSView
//
//  Created by Esat Gözcü on 21.01.2025.
//

import SwiftUI

struct FSPrimarySortingView: View {
    private let config = FSMainConfig.shared.primarySortingConfig
    let item: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(item)
                .font(config.textFont)
                .padding(.horizontal, config.padding)
                .frame(height: config.height)
                .background(
                    RoundedRectangle(
                        cornerRadius: config.cornerRadius
                    )
                    .fill(
                        isSelected
                        ? config.selectedBackgroundColor
                        : config.backgroundColor
                    )
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: config.cornerRadius
                        )
                        .strokeBorder(
                            isSelected
                            ? config.selectedBorderColor
                            : config.borderColor,
                            lineWidth: config.borderWidth
                        )
                    )
                )
                .foregroundColor(
                    isSelected
                    ? config.selectedTextColor
                    : config.textColor
                )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

//Test view
#if DEBUG
#Preview {
    TestFSPrimarySortingView()
}
private struct TestFSPrimarySortingView: View {
    @State var isSelected = false
    
    var body: some View {
        VStack{
            FSPrimarySortingView(
                item: "Sorting View",
                isSelected: isSelected
            ) {
                isSelected.toggle()
            }
        }
    }
}
#endif
