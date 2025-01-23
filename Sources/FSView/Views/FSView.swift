//
//  FSView.swift
//  FSView
//
//  Created by Esat Gözcü on 6.01.2025.
//

import SwiftUI

struct FSView: View {
    private let mainConfig = FSMainConfig.shared
    @Binding var sortingItems: [SortingItemModel]
    @Binding var filteringItems: [FilteringItemModel]
    let sortingItemClicked: () -> ()
    let filteringItemClicked: () -> ()
    let primarySortingItemClicked: (SortingItemModel) -> ()
    let primaryFilteringItemClicked: (FilteringItemModel) -> ()
    
    var body: some View {
        let totalSpacing =
        (mainConfig.stickyConfig.padding*2) +
        mainConfig.stickyConfig.spacing
        
        let minWidth =
        mainConfig.stickyFilteringConfig.minWidth +
        mainConfig.stickySortingConfig.minWidth +
        totalSpacing
        
        let defaultWidth =
        mainConfig.stickyFilteringConfig.defaultWidth +
        mainConfig.stickySortingConfig.defaultWidth +
        totalSpacing
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: mainConfig.fsViewConfig.spacing) {
                FSStickyView(
                    minWidth: minWidth,
                    defaultWidth: defaultWidth,
                    minXOffset: 0,
                    isSortingSelected: sortingItems.filter{
                        $0.isDefault != true
                    }.contains{
                        $0.isSelected == true
                    },
                    selectedFilteringCount: filteringItems.filter{
                        $0.isSelected == true
                    }.count,
                    sortingClicked: {
                        sortingItemClicked()
                    },
                    filteringClicked: {
                        filteringItemClicked()
                    }
                ).zIndex(2)
                //MARK: Sorting
                ForEach(
                    sortingItems.filter{
                        $0.isPrimary == true
                    },
                    id: \.id
                ) { item in
                    FSPrimarySortingView(
                        item: item.title,
                        isSelected: item.isSelected,
                        action: {
                            primarySortingItemClicked(item)
                        }
                    )
                }
                //MARK: Filtering
                ForEach(
                    filteringItems.filter{
                        $0.isPrimary == true
                    }, id: \.id
                ) { item in
                    getFilterItems(item: item)
                }
            }.padding(
                .trailing, mainConfig.fsViewConfig.spacing
            )
        }.background(
            mainConfig.fsViewConfig.scrollBackground
        )
    }
    //MARK: Filter items
    @ViewBuilder
    func getFilterItems(item: FilteringItemModel) -> some View {
        switch item.type {
        case .normal:
            FSPrimaryView(
                item: item.title,
                isSelected: item.isSelected,
                action: {
                    primaryFilteringItemClicked(item)
                }
            )
        case .withIcon(let typeModel):
            FSPrimaryIconView(
                item: item.title,
                isSelected: item.isSelected,
                typeModel: typeModel,
                action: {
                    primaryFilteringItemClicked(item)
                }
            )
        case .toggle:
            FSPrimaryToggleView(
                item: item.title,
                isOpened: item.isOpened,
                action: {
                    primaryFilteringItemClicked(item)
                }
            )
        }
    }
}

//Test view
#if DEBUG
#Preview {
    TestFSView()
}
private struct TestFSView: View {
    @State var sortingItems: [SortingItemModel] = [
        SortingItemModel(title: "Most Expensive"),
        SortingItemModel(title: "Cheapest"),
        SortingItemModel(title: "Top Selling"),
        SortingItemModel(
            title: "Most Rated",
            isPrimary: true
        )
    ]
    @State var filteringItems: [FilteringItemModel] = [
        FilteringItemModel(
            title: "Most Commented",
            isPrimary: true
        ),
        FilteringItemModel(
            title: "Categories",
            isPrimary: true,
            type: .toggle
        ),
        FilteringItemModel(
            title: "Bestsellers",
            isPrimary: true,
            type: .withIcon(
                PrimaryIconModel(
                    icon: Image(
                        systemName: "gauge.open.with.lines.needle.67percent.and.arrowtriangle"
                    ),
                    iconForegroundColor: .red,
                    selectedBackgroundColor: .red.opacity(0.05),
                    backgroundColor: .red.opacity(0.01),
                    selectedBorderColor: .red,
                    borderColor: .red.opacity(0.2)
                )
            )
        ),
        FilteringItemModel(
            title: "Free shipping",
            isPrimary: true,
            type: .withIcon(
                PrimaryIconModel(
                    icon: Image(
                        systemName: "shippingbox.and.arrow.backward"
                    ),
                    iconForegroundColor: .green,
                    selectedBackgroundColor: .green.opacity(0.05),
                    backgroundColor: .green.opacity(0.01),
                    selectedBorderColor: .green,
                    borderColor: .green.opacity(0.2)
                )
            )
        ),
        FilteringItemModel(
            title: "Flash discount",
            isPrimary: true,
            type: .withIcon(
                PrimaryIconModel(
                    icon: Image(
                        systemName: "arrow.down.left.square.fill"
                    ),
                    iconForegroundColor: .green
                )
            )
        )
    ]
    var body: some View {
        FSView(
            sortingItems: $sortingItems,
            filteringItems: $filteringItems,
            sortingItemClicked: {},
            filteringItemClicked: {},
            primarySortingItemClicked: {_ in},
            primaryFilteringItemClicked: {_ in}
        )
    }
}
#endif
