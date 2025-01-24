//
//  FilteringView.swift
//  FSViewExample
//
//  Created by Esat Gözcü on 23.01.2025.
//

import SwiftUI
import FSView

struct FilteringView: View {
    @Binding var filteringItems: [FilteringItemModel]
    var onClose: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Filters")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(action: { onClose() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                }
            }
            .padding()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    // Normal Filters Section
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Normal Filters")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach($filteringItems.filter { $0.wrappedValue.itemType.isNormal == true }) { $item in
                                    NormalFilterButton(item: $item)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Toggle Filters Section
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Toggle Filters")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        VStack(spacing: 10) {
                            ForEach($filteringItems.filter { $0.wrappedValue.itemType.isToggle }) { $item in
                                if case .toggle(let toggleModels) = item.itemType {
                                    ToggleFilterButton(item: $item, toggleModels: toggleModels)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // WithIcon Filters Section
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Icon Filters")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 10) {
                                ForEach($filteringItems.filter { $0.wrappedValue.itemType.isWithIcon }) { $item in
                                    if case .withIcon(let iconModel) = item.itemType {
                                        IconFilterButton(item: $item, iconModel: iconModel)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

struct NormalFilterButton: View {
    @Binding var item: FilteringItemModel
    
    var body: some View {
        Button(action: { item.isSelected.toggle() }) {
            Text(item.title)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(item.isSelected ? Color.blue.opacity(0.1) : Color.clear)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(item.isSelected ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
                )
        }.padding(1)
    }
}

struct ToggleFilterButton: View {
    @Binding var item: FilteringItemModel
    @State var toggleModels: [PrimaryToggleModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .fontWeight(.semibold)
            
            ForEach(toggleModels.indices, id: \.self) { index in
                Toggle(toggleModels[index].title, isOn: Binding(
                    get: { toggleModels[index].isSelected },
                    set: { newValue in
                        toggleModels[index].isSelected = newValue
                        item.itemType = .toggle(toggleModels)
                    }
                ))
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(10)
    }
}

struct IconFilterButton: View {
    @Binding var item: FilteringItemModel
    let iconModel: PrimaryIconModel
    
    var body: some View {
        HStack{
            iconModel.icon
                .foregroundColor(item.isSelected ?
                                 (iconModel.iconForegroundColor ?? .blue) :
                        .gray)
                .frame(width: 25, height: 25)
                .padding(2)
            Text(item.title)
        }
        .padding(10)
        .background(item.isSelected ?
                    iconModel.selectedBackgroundColor :
                        iconModel.backgroundColor)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(item.isSelected ?
                        iconModel.selectedBorderColor :
                            iconModel.borderColor,
                        lineWidth: 2)
        )
        .padding(1)
        .onTapGesture {
            item.isSelected.toggle()
        }
    }
}
