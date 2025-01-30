//
//  ContentView.swift
//  FSViewExample
//
//  Created by Esat Gözcü on 23.01.2025.
//

import SwiftUI
import FSView

struct ContentView: View {
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
    @State private var filteringViewVisible = false
    @State private var sortingViewVisible = false
    @State private var toggleViewVisible = false{
        didSet{
            if !toggleViewVisible{
                if let index = filteringItems.firstIndex(where: {$0.title == "Categories"}){
                    filteringItems[index].isSelected = false
                }
            }
        }
    }
    
    var body: some View {
        VStack{
            FSView(
                sortingItems: $sortingItems,
                filteringItems: $filteringItems,
                sortingItemClicked: {
                    sortingViewVisible.toggle()
                    toggleViewVisible = false
                },
                filteringItemClicked: {
                    filteringViewVisible.toggle()
                    toggleViewVisible = false
                    sortingViewVisible = false
                },
                primarySortingItemClicked: { item in
                    sortingViewVisible = false
                    filteringViewVisible = false
                    toggleViewVisible = false
                    
                    for index in sortingItems.indices {
                        sortingItems[index].isSelected = false
                    }
                    // Current item select/deselect
                    if let selectedIndex = sortingItems.firstIndex(where: { $0.id == item.id }) {
                        sortingItems[selectedIndex].isSelected = !item.isSelected
                    }
                    // If no item is selected, make the “Recommended-Default” item selected.
                    if !sortingItems.contains(where: { $0.isSelected }) {
                        if let recommendedIndex = sortingItems.firstIndex(where: { $0.isDefault }) {
                            sortingItems[recommendedIndex].isSelected = true
                        }
                    }
                },
                primaryFilteringItemClicked: { item in
                    filteringItems[filteringItems.firstIndex{$0.id == item.id}!].isSelected = !item.isSelected
                    
                    if case .toggle = item.itemType {
                        toggleViewVisible.toggle()
                        sortingViewVisible = false
                    }else{
                        sortingViewVisible = false
                        filteringViewVisible = false
                        toggleViewVisible = false
                    }
                }
            ).zIndex(2)
            ZStack(alignment: .top) {
                ExampleProductGridView()
                    .overlay{
                        if sortingViewVisible {
                            Color(UIColor.label).opacity(0.2)
                                .onTapGesture {
                                    withAnimation(.easeOut(duration: 0.1)) {
                                        sortingViewVisible = false
                                    }
                                }.ignoresSafeArea()
                        }
                        if toggleViewVisible {
                            Color(UIColor.label).opacity(0.2)
                                .onTapGesture {
                                    withAnimation(.easeOut(duration: 0.1)) {
                                        toggleViewVisible = false
                                    }
                                }.ignoresSafeArea()
                        }
                    }
                    .zIndex(0)
                // SortingView
                if sortingViewVisible {
                    SortingView(
                        sortingItems: $sortingItems, itemClicked: { item in
                            if let index = sortingItems.firstIndex(where: { $0.id == item.id }) {
                                // Check if the item is already selected
                                if !sortingItems[index].isSelected {
                                    // Set the matched item's isSelected to true
                                    sortingItems[index].isSelected = true
                                    // Set all other items' isSelected to false
                                    for i in sortingItems.indices {
                                        if i != index {
                                            sortingItems[i].isSelected = false
                                        }
                                    }
                                }
                            }
                            sortingViewVisible = false
                        }
                    )
                    .transition(.move(edge: .top))
                    .zIndex(1)
                }
                // ToggleView
                if toggleViewVisible {
                    ToggleView(
                        items: filteringItems.filter{$0.title == "Categories"}.first?.getPrimaryToggleModel() ?? [],
                        result:{ list in
                            if let index = filteringItems.firstIndex(where: {$0.title == "Categories"}){
                                filteringItems[index].itemType = .toggle(list)
                                withAnimation(.easeOut(duration: 0.1)) {
                                    toggleViewVisible = false
                                }
                            }
                        }
                    )
                    .transition(.move(edge: .top))
                    .zIndex(1)
                }
            }
        }
        .animation(.easeOut(duration: 0.2), value: sortingViewVisible)
        .animation(.easeOut(duration: 0.2), value: toggleViewVisible)
        .fullScreenCover(
            isPresented: $filteringViewVisible,
            content: {
                FilteringView(filteringItems: $filteringItems) {
                    filteringViewVisible = false
                }
            }
        )
    }
}

struct ExampleProductGridView: View {
    let items = Array(1...20)
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(items, id: \.self) { item in
                    ZStack {
                        VStack {}
                            .frame(height: 100)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                            .shadow(color: Color.gray.opacity(0.1), radius: 6, x: 0, y: 4)
                            .padding(5)
                        // Watermark text
                        Text("Product")
                            .font(.body)
                            .foregroundColor(.black)
                            .opacity(0.5)
                            .rotationEffect(.degrees(-45))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
        }
    }
}
#Preview {
    ContentView()
}
