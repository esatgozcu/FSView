//
//  FSStickyView.swift
//  FSView
//
//  Created by Esat Gözcü on 11.01.2025.
//

import SwiftUI

struct FSStickyView: View {
    private let stickyConfig = FSMainConfig.shared.stickyConfig
    let minWidth: CGFloat
    let defaultWidth: CGFloat
    let minXOffset: CGFloat
    let isSortingSelected: Bool
    let selectedFilteringCount: Int
    let sortingClicked: () -> ()
    let filteringClicked: () -> ()
    
    var body: some View {
        GeometryReader { geometry in
            let minX =
            geometry.frame(in: .global).minX
            - minXOffset
            
            let isScrolled = minX < 0
            
            let totalSpacing =
            stickyConfig.padding*2 +
            stickyConfig.spacing
            
            let width =
            isScrolled
            ? (max(minWidth, defaultWidth - abs(minX))/2) - totalSpacing/2
            : defaultWidth/2 - totalSpacing/2
                        
            HStack(spacing: 0) {
                HStack(spacing: stickyConfig.spacing) {
                    FSStickySortingView(
                        width: width,
                        isSelected: isSortingSelected,
                        isScrolled: isScrolled
                    ) {
                        sortingClicked()
                    }
                    FSStickyFilteringView(
                        width: width,
                        selectedFilteringCount: selectedFilteringCount,
                        isScrolled: isScrolled
                    ) {
                        filteringClicked()
                    }
                }
                .padding(.horizontal, stickyConfig.padding)
                
                let totalWidth =
                FSMainConfig.shared.stickySortingConfig.minWidth +
                FSMainConfig.shared.stickyFilteringConfig.minWidth
                Divider().frame(
                    height: minX < -totalWidth
                    ? stickyConfig.dividerHeight
                    : 0
                ).background(stickyConfig.dividerColor)
            }
            .frame(height: stickyConfig.height)
            .background(stickyConfig.backgroundColor)
            .offset(
                x: isScrolled ? -minX : 0
            )
        }
        .frame(
            width: defaultWidth,
            height: stickyConfig.height
        )
    }
}

//Test view
#if DEBUG
#Preview {
    TestFSStickyView()
}
private struct TestFSStickyView: View {
    @State var isSortingSelected = false
    @State var isFilteringSelected = true
    
    var body: some View {
        VStack{
            FSStickyView(
                minWidth: 130,
                defaultWidth: 230,
                minXOffset: 0,
                isSortingSelected: isSortingSelected,
                selectedFilteringCount: isFilteringSelected ? 1 : 0,
                sortingClicked: {
                    isSortingSelected.toggle()
                },
                filteringClicked: {
                    isFilteringSelected.toggle()
                }
            )
        }
    }
}
#endif
