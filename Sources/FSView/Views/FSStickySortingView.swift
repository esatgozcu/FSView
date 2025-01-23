//
//  FSStickySortingView.swift
//  FSView
//
//  Created by Esat Gözcü on 11.01.2025.
//

import SwiftUI

struct FSStickySortingView: View {
    private let config = FSMainConfig.shared.stickySortingConfig
    let width: CGFloat
    let isSelected: Bool
    let isScrolled: Bool
    let sortingClicked: () -> ()
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    isSelected
                    ? config.selectedBackgroundColor
                    : config.backgroundColor
                )
                .frame(width: width)
                .cornerRadius(config.cornerRadius)
                .overlay(
                    RoundedRectangle(
                        cornerRadius: config.cornerRadius
                    ).stroke(
                        isSelected
                        ? config.selectedBorderColor
                        : config.borderColor,
                        lineWidth: config.borderWidth
                    )
                )
                .animation(
                    .spring(
                        response: 0.3,
                        dampingFraction: 0.7
                    ),
                    value: isSelected
                )
            HStack(spacing: 6) {
                if !isScrolled {
                    renderImage(for: config.imageSize)
                    Text(config.text)
                        .font(config.textFont)
                        .foregroundColor(config.textColor)
                        .transition(
                            .move(edge: .leading)
                            .combined(with: .opacity)
                        )
                }
                else {
                    renderImage(for: config.scrolledImageSize)
                }
            }
            .animation(
                .spring(
                    response: 0.3,
                    dampingFraction: 0.8
                ), value: isScrolled
            )
        }
        .frame(height: config.height)
        .onTapGesture {
            sortingClicked()
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
    TestFSStickySortingView()
}
private struct TestFSStickySortingView: View {
    @State var isSelected = false
    @State var isScrolled = false
    
    var body: some View {
        VStack{
            FSStickySortingView(
                width: 100,
                isSelected: isSelected,
                isScrolled: isScrolled
            ) {
                isSelected.toggle()
                isScrolled.toggle()
            }
        }
    }
}
#endif
