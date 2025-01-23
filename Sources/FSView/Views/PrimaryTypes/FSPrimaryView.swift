//
//  FSPrimaryView.swift
//  FSView
//
//  Created by Esat Gözcü on 11.01.2025.
//

import SwiftUI

struct FSPrimaryView: View {
    private let config = FSMainConfig.shared.primaryConfig
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
    TestFSPrimaryView()
}
private struct TestFSPrimaryView: View {
    @State var isSelected = false
    
    var body: some View {
        VStack{
            FSPrimaryView(
                item: "Primary Item",
                isSelected: isSelected
            ) {
                isSelected.toggle()
            }
        }
    }
}
#endif
