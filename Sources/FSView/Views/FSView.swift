//
//  FSView.swift
//  FSView
//
//  Created by Esat Gözcü on 6.01.2025.
//

import SwiftUI

public struct FSView: View {
    private let mainConfig = FSMainConfig.shared
    @Binding var sortingItems: [SortingItemModel]
    @Binding var filteringItems: [FilteringItemModel]
    let sortingItemClicked: () -> ()
    let filteringItemClicked: () -> ()
    let primarySortingItemClicked: (SortingItemModel) -> ()
    let primaryFilteringItemClicked: (FilteringItemModel) -> ()
    
    public init(
        sortingItems: Binding<[SortingItemModel]>,
        filteringItems: Binding<[FilteringItemModel]>,
        sortingItemClicked: @escaping () -> Void,
        filteringItemClicked: @escaping () -> Void,
        primarySortingItemClicked: @escaping (SortingItemModel) -> Void,
        primaryFilteringItemClicked: @escaping (FilteringItemModel) -> Void
    ) {
        self._sortingItems = sortingItems
        self._filteringItems = filteringItems
        self.sortingItemClicked = sortingItemClicked
        self.filteringItemClicked = filteringItemClicked
        self.primarySortingItemClicked = primarySortingItemClicked
        self.primaryFilteringItemClicked = primaryFilteringItemClicked
    }
    
    public var body: some View {
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
                    isSortingSelected: isSortingSelected(),
                    selectedFilteringCount: filteredItemCount(),
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
        switch item.itemType {
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
        case .toggle(let toggleModel):
            FSPrimaryToggleView(
                item: item.title,
                isActive: detectToggleIsActive(
                    isSelected: item.isSelected,
                    toggleModel: toggleModel
                ), 
                isOpened: item.isSelected,
                action: {
                    primaryFilteringItemClicked(item)
                }
            )
        }
    }
    private func detectToggleIsActive(isSelected: Bool, toggleModel: [PrimaryToggleModel]) -> Bool{
        if isSelected == true{
            return true
        }
        else{
            return toggleModel.contains{
                $0.isSelected == true
            }
        }
    }
    private func isSortingSelected() -> Bool{
        return sortingItems.filter{
            $0.isDefault != true
        }.contains{
            $0.isSelected == true
        }
    }
    private func filteredItemCount() -> Int {
        return filteringItems.reduce(0) { (total, item) in
            switch item.itemType {
            case .normal, .withIcon:
                return total + (item.isSelected ? 1 : 0)
            case .toggle(let toggleModel):
                return total + toggleModel.filter(\.isSelected).count
            }
        }
    }
}

//Test view
#if DEBUG
#Preview {
    TestFSView()
}
private struct TestFSView: View {
    @State private var sortingItems: [SortingItemModel] = [
        SortingItemModel(title: "Recommended", isSelected: true, isDefault: true),
        SortingItemModel(title: "Most Expensive"),
        SortingItemModel(title: "Cheapest"),
        SortingItemModel(title: "Top Selling"),
        SortingItemModel(
            title: "Most Rated",
            isPrimary: true
        )
    ]
    @State private var filteringItems: [FilteringItemModel] = [
        FilteringItemModel(
            title: "In Stock",
            isPrimary: false
        ),
        FilteringItemModel(
            title: "Coming soon",
            isPrimary: false
        ),
        FilteringItemModel(
            title: "Categories",
            isPrimary: true,
            type: .toggle(
                [
                    PrimaryToggleModel(title: "Shoes"),
                    PrimaryToggleModel(title: "Clothing"),
                    PrimaryToggleModel(title: "Sports"),
                    PrimaryToggleModel(title: "Cosmetics"),
                    PrimaryToggleModel(title: "Personal"),
                    PrimaryToggleModel(title: "Care"),
                    PrimaryToggleModel(title: "Accessories"),
                    PrimaryToggleModel(title: "Electronics")
                ]
            )
        ),
        FilteringItemModel(
            title: "Brands",
            isPrimary: false,
            type: .toggle(
                [
                    PrimaryToggleModel(title: "Puma"),
                    PrimaryToggleModel(title: "Reebok"),
                    PrimaryToggleModel(title: "Under Armour"),
                    PrimaryToggleModel(title: "Asics")
                ]
            )
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
                    selectedBackgroundColor: .red.opacity(0.1),
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
                    selectedBackgroundColor: .green.opacity(0.1),
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
