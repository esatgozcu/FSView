//
//  FSPrimaryToggleView.swift
//  FSView
//
//  Created by Esat Gözcü on 21.01.2025.
//

import SwiftUI

struct FSPrimaryToggleView: View {
    private let config = FSMainConfig.shared.primaryToggleConfig
    let item: String
    let isActive: Bool
    let isOpened: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: config.spacing){
                Text(item)
                    .font(config.textFont)
                    .frame(height: config.height)
                    .foregroundColor(
                        isActive
                        ? config.selectedTextColor
                        : config.textColor
                    )
                Image(systemName: config.imageSystemName)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: config.imageSize.width,
                        height: config.imageSize.height
                    )
                    .rotationEffect(.degrees(isOpened ? 180 : 0))
                    .animation(
                        .easeInOut(duration: 0.2),
                        value: isOpened
                    )
            }
            .padding(.horizontal, config.padding)
            .background(
                RoundedRectangle(
                    cornerRadius: config.cornerRadius
                )
                .fill(
                    isActive
                    ? config.selectedBackgroundColor
                    : config.backgroundColor
                )
                .overlay(
                    RoundedRectangle(
                        cornerRadius: config.cornerRadius
                    )
                    .strokeBorder(
                        isActive
                        ? config.selectedBorderColor
                        : config.borderColor,
                        lineWidth: config.borderWidth
                    )
                )
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

#Preview {
    TestFSPrimaryToggleView()
}

//Test view
#if DEBUG
private struct TestFSPrimaryToggleView: View {
    @State var isActive = false
    
    var body: some View {
        VStack{
            FSPrimaryToggleView(
                item: "Primary Item",
                isActive: isActive,
                isOpened: true
            ) {
                isActive.toggle()
            }
        }
    }
}
#endif
