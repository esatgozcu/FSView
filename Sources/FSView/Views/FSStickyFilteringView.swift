//
//  FSStickyFilteringView.swift
//  FSView
//
//  Created by Esat Gözcü on 11.01.2025.
//

import SwiftUI

struct FSStickyFilteringView: View {
    private let config = FSMainConfig.shared.stickyFilteringConfig
    let width: CGFloat
    let selectedFilteringCount: Int
    let isScrolled: Bool
    let filteringClicked: () -> ()
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    selectedFilteringCount > 0
                    ? config.selectedBackgroundColor
                    : config.backgroundColor
                )
                .frame(width: width)
                .cornerRadius(config.cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: config.cornerRadius)
                        .stroke(
                            selectedFilteringCount > 0
                            ? config.selectedBorderColor
                            : config.borderColor,
                            lineWidth: config.borderWidth
                        )
                )
                .animation(
                    .spring(
                        response: 0.3, dampingFraction: 0.7
                    ),
                    value: selectedFilteringCount
                )
            HStack(spacing: 6) {
                if !isScrolled {
                    renderImage(for: config.imageSize)
                    Text(config.text)
                        .font(config.textFont)
                        .foregroundColor(
                            selectedFilteringCount > 0
                            ? config.selectedTextColor
                            : config.textColor
                        )
                        .transition(
                            .move(edge: .leading)
                            .combined(with: .opacity)
                        )
                        .lineLimit(1)
                } else {
                    renderImage(for: config.scrolledImageSize)
                }
            }
            .animation(
                .spring(
                    response: 0.3,
                    dampingFraction: 0.8
                ), value: isScrolled
            )
            if selectedFilteringCount > 0 {
                Text("\(selectedFilteringCount)")
                    .font(config.badgeFont)
                    .frame(height: 8)
                    .foregroundColor(config.badgeTextColor)
                    .padding(config.badgePadding)
                    .background(
                        Circle().fill(config.badgeBackgroundColor)
                    )
                    .offset(
                        x: width/2 + config.badgeOffset.x,
                        y: -config.height/2 - config.badgeOffset.y
                    )
                    .animation(
                        .spring(), value: selectedFilteringCount
                    )
            }
        }
        .frame(height: config.height)
        .onTapGesture {
            filteringClicked()
        }
    }
    @ViewBuilder
    private func renderImage(for size: CGSize) -> some View {
        config.image
            .resizable()
            .scaledToFit()
            .frame(
                width: size.width,
                height: size.height
            )
            .foregroundColor(
                config.systemImageForegroundColor
            )
            .transition(.scale.combined(with: .opacity))
    }
}

//Test view
#if DEBUG
#Preview {
    TestFSStickyFilteringView()
}
private struct TestFSStickyFilteringView: View {
    @State var isScrolled = false
    
    var body: some View {
        VStack{
            FSStickyFilteringView(
                width: 100,
                selectedFilteringCount: 9,
                isScrolled: isScrolled
            ){
                isScrolled.toggle()
            }
            FSStickyFilteringView(
                width: 100,
                selectedFilteringCount: 0,
                isScrolled: isScrolled
            ){
                isScrolled.toggle()
            }
        }
    }
}
#endif
