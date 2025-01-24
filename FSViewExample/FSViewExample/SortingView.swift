//
//  FSSortingView.swift
//  FSView
//
//  Created by Esat Gözcü on 11.01.2025.
//

import SwiftUI
import FSView

struct SortingView: View {
    @Binding var sortingItems: [SortingItemModel]
    var itemClicked: (SortingItemModel) -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(sortingItems) { item in
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .stroke(item.isSelected ? Color.orange : Color.gray, lineWidth: 1)
                            .frame(width: 14, height: 14)
                        Circle()
                            .fill(item.isSelected ? Color.orange : Color.clear)
                            .frame(width: 10, height: 10)
                    }
                    Text(item.title)
                        .foregroundColor(.primary)
                        .font(.system(size: 14))

                    Spacer()
                }
                .padding(.horizontal, 16)
                .frame(height: 44)
                .cornerRadius(8)
                .onTapGesture {
                    itemClicked(item)
                }
            }
        }
        .padding(.vertical, 8)
        .background(Color(UIColor.systemBackground))
    }
}

#Preview {
    TestSortingView()
}
//TEST
private struct TestSortingView: View {
    @State var sortingItems: [SortingItemModel] = [
        SortingItemModel(
            title: "Recommended",
            isSelected: true,
            isDefault: true
        ),
        SortingItemModel(title: "Most Expensive"),
        SortingItemModel(title: "Cheapest"),
        SortingItemModel(title: "Top Selling"),
        SortingItemModel(
            title: "Most Rated",
            isPrimary: true
        )
    ]
    var body: some View {
        SortingView(sortingItems: $sortingItems) { item in
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
        }
    }
}
