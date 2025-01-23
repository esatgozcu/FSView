//
//  FSStickyView.swift
//  FSView
//
//  Created by Esat Gözcü on 11.01.2025.
//

import SwiftUI

struct FSStickyView: View {
    private let stickConfig = FSMainConfig.shared.stickyConfig
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
            stickConfig.padding*2 +
            stickConfig.spacing
            
            let width =
            isScrolled
            ? (max(minWidth, defaultWidth - abs(minX))/2) - totalSpacing/2
            : defaultWidth/2 - totalSpacing/2
                        
            HStack(spacing: 0) {
                HStack(spacing: stickConfig.spacing) {
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
                .padding(.horizontal, stickConfig.padding)
                
                let totalWidth =
                FSMainConfig.shared.stickySortingConfig.minWidth +
                FSMainConfig.shared.stickyFilteringConfig.minWidth
                Divider().frame(
                    height: minX < -totalWidth
                    ? stickConfig.dividerHeight
                    : 0
                )
            }
            .frame(height: stickConfig.height)
            .background(stickConfig.backgroundColor)
            .offset(
                x: isScrolled ? -minX : 0
            )
        }
        .frame(
            width: defaultWidth,
            height: stickConfig.height
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
