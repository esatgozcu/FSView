//
//  HomeFilteringView.swift
//  FSView
//
//  Created by Esat Gözcü on 11.01.2025.
//

import SwiftUI
import FSView

struct ToggleView: View {
    @State var items: [PrimaryToggleModel]
    var result: ([PrimaryToggleModel]) -> ()
    
    var body: some View {
        VStack(spacing: 12) {
            ScrollView{
                VStack(spacing: 12) {
                    ForEach(0..<(items.count + 1) / 2, id: \.self) { row in
                        HStack(spacing: 12) {
                            HStack(spacing: 12) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(items[row * 2].isSelected ? Color.orange : Color.gray, lineWidth: 1)
                                        .frame(width: 16, height: 16)
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(items[row * 2].isSelected ? Color.orange : Color.clear)
                                        .frame(width: 12, height: 12)
                                }
                                .padding(2)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    items[row * 2].isSelected.toggle()
                                }
                                Text(items[row * 2].title)
                                    .foregroundColor(.primary)
                                    .font(.system(size: 14))
                                    .onTapGesture {
                                        items[row * 2].isSelected.toggle()
                                    }
                                Spacer()
                            }
                            .frame(height: 32)
                            // Right column (if it exists)
                            if row * 2 + 1 < items.count {
                                HStack(spacing: 12) {
                                    let index = row * 2 + 1
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(
                                                items[index].isSelected
                                                ? Color.orange
                                                : Color.gray,
                                                lineWidth: 1
                                            )
                                            .frame(width: 16, height: 16)
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(
                                                items[index].isSelected
                                                ? Color.orange
                                                : Color.clear
                                            )
                                            .frame(width: 12, height: 12)
                                    }
                                    .padding(2)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        items[index].isSelected.toggle()
                                    }
                                    Text(items[index].title)
                                        .foregroundColor(.primary)
                                        .font(.system(size: 14))
                                        .onTapGesture {
                                            items[index].isSelected.toggle()
                                        }
                                    Spacer()
                                }
                                .frame(height: 32)
                            } else {
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(maxHeight: 120)
            Divider()
            // Clear and Apply
            HStack(spacing: 16){
                Button(action: {
                    items = items.map { item in
                            var updatedItem = item
                            updatedItem.isSelected = false
                            return updatedItem
                        }
                    result(items)
                }) {
                    Text("Clear")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 14))
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                Button(action: {
                    result(items)
                }) {
                    Text("Apply")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(8)
                }
            }.padding(.horizontal, 16)
        }
        .padding(.vertical, 12)
        .background(Color(UIColor.systemBackground))
    }
}
