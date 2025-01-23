//
//  FSFilterWithIconView.swift
//  FSView
//
//  Created by Esat Gözcü on 20.01.2025.
//

import SwiftUI

struct FSPrimaryIconView: View {
    private let config = FSMainConfig.shared.primaryIconConfig
    let item: String
    let isSelected: Bool
    let typeModel: PrimaryIconModel
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing:config.spacing){
                typeModel.icon
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(
                        typeModel.iconForegroundColor
                    )
                    .frame(
                        width: config.imageSize.width,
                        height: config.imageSize.height
                    )
                Text(item)
                    .font(config.textFont)
                    .foregroundColor(
                        isSelected
                        ? config.selectedTextColor
                        : config.textColor
                    )
                    .frame(height: config.height)
            }
            .padding(.horizontal, config.padding)
            .background(
                RoundedRectangle(
                    cornerRadius: config.cornerRadius
                )
                .fill(
                    isSelected
                    ? typeModel.selectedBackgroundColor
                    : typeModel.backgroundColor
                )
                .overlay(
                    RoundedRectangle(
                        cornerRadius: config.cornerRadius
                    )
                    .strokeBorder(
                        isSelected
                        ? typeModel.selectedBorderColor
                        : typeModel.borderColor,
                        lineWidth: config.borderWidth
                    )
                )
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

//Test view
#if DEBUG
#Preview {
    TestFSFilterWithIconView()
}
private struct TestFSFilterWithIconView: View {
    @State var isSelected = false
    
    var body: some View {
        VStack{
            FSPrimaryIconView(
                item: "Primary Item",
                isSelected: isSelected,
                typeModel: .init(
                    icon: Image(
                        systemName: "gauge.open.with.lines.needle.67percent.and.arrowtriangle"
                    ),
                    iconForegroundColor: .red,
                    selectedBackgroundColor: .red.opacity(0.05),
                    backgroundColor: .red.opacity(0.01),
                    selectedBorderColor: .red,
                    borderColor: .red.opacity(0.2)
                ),
                action: {
                    isSelected.toggle()
                }
            )
            FSPrimaryIconView(
                item: "Primary Item",
                isSelected: isSelected,
                typeModel: .init(
                    icon: Image(
                        systemName: "gauge.open.with.lines.needle.67percent.and.arrowtriangle"
                    ),
                    iconForegroundColor: .green
                ),
                action: {
                    isSelected.toggle()
                }
            )
        }
    }
}
#endif
