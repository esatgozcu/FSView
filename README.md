<p align="center">
    <img src="https://img.shields.io/badge/Min-iOS 15.0+-cyan.svg" alt="iOS 15.0+" />
    <img src="https://img.shields.io/badge/UI-SwiftUI-red.svg" alt="SwiftUI" />
    <img src="https://img.shields.io/badge/licence-MIT-blue.svg?style=flat" alt="MIT License" />
    <a href= "https://linkedin.com/in/esatgozcu">
        <img src="https://img.shields.io/badge/contact-@esatgozcu-green.svg?style=flat" />
    </a>
</p>

# FSView - SwiftUI Filtering & Sorting Component

FSView is a versatile and intuitive SwiftUI component designed to streamline **filtering** and **sorting** operations in your applications. It provides users with a seamless interface to sort and filter products or items effortlessly.

<p align="center">
    <img src ="https://github.com/user-attachments/assets/562905da-7866-455c-a70b-45da6219f0b9" alt="Logo" title="FSView" width=400 />
</p>

### 🚀 Features

- **Dynamic Visibility**:
  - Sorting and filtering panels dynamically open and close based on user interaction.
- **Customizable UI**:
  - Toggle View: Allows multi-selection for categories, brands, and similar items.
  - Icon-based Filtering: Includes visually distinct options for specific filters.
- **Built with SwiftUI**:
  - Fully utilizes SwiftUI's animations and modern view-building principles.


### 📦 Swift Package Manager

FSView is available through [Swift Package Manager](https://swift.org/package-manager/). Add FSView as a dependency to your `Package.swift`:

```Swift
.package(url: "https://github.com/esatgozcu/FSView", from: "main")
```


### ⚙️ Version Compatibility

- iOS 15.0+


### 🛠️ Usage

Here’s a sample implementation of **FSView**:

```swift
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

    var body: some View {
        FSView(
            sortingItems: $sortingItems,
            filteringItems: $filteringItems,
            sortingItemClicked: {
                print("Sorting item clicked!")
            },
            filteringItemClicked: {
                print("Filtering item clicked!")
            },
            primarySortingItemClicked: { item in
                print("Primary sorting item clicked: \(item.title)")
            },
            primaryFilteringItemClicked: { item in
                print("Primary filtering item clicked: \(item.title)")
            }
        )
    }
}
```
#### Notes

- isDefault: The isDefault value applies to the sorting model, and it is recommended to set isDefault to true for recommended items. If true, the sorting border will remain in the default color.
- isPrimary: It represents the primary items that are intended to be displayed in the right flow. Only values that are true will be shown.
- There are three types of primary buttons: Normal, withIcon, and Toggle buttons. You can customize these buttons.

### 💡 Customization

#### Updating Configurations

`FSMainConfig` uses a singleton approach, making it accessible throughout your app:
```swift
let config = FSMainConfig.shared
```

#### Example:

```swift
import SwiftUI
import FSView

@main
struct FSViewApp: App {
    let config = FSMainConfig.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        updateDataBeforeLaunch()
    }
    
    //MARK: Update UI
    private func updateDataBeforeLaunch() {
        config.updateFsViewConfig { fsViewConfig in
            fsViewConfig.spacing = 10
        }
        config.updateFsStickConfig { stickyConfig in
            stickyConfig.dividerColor = .red
        }
    }
}

```

### Configuration Sections

#### FSViewConfig

<img width="294" alt="FSViewConfig" src="https://github.com/user-attachments/assets/9a81e284-0716-4d65-bbb5-d5a69d7fea29" />

General settings for spacing and scroll background.

- **Properties**:
  - `spacing`: `CGFloat` = `5`
  - `scrollBackground`: `Color` = `systemBackground`

#### FSStickyConfig

<img width="177" alt="FSStickyConfig" src="https://github.com/user-attachments/assets/b2bbfd30-c55c-4065-99ca-d4e75953785d" />

Settings for sticky headers, including height, padding, and divider properties.

- **Properties**:
  - `backgroundColor`: `Color` = `systemBackground`
  - `dividerHeight`: `CGFloat` = `36`
  - `dividerColor`: `Color` = `separator`
  - `height`: `CGFloat` = `40`
  - `padding`: `CGFloat` = `10`
  - `spacing`: `CGFloat` = `10`

#### FSStickySortingConfig

<img width="98" alt="FSStickySortingConfig" src="https://github.com/user-attachments/assets/023a345c-2984-4e0d-a6f4-6a31582ffc1e" />

Sticky sorting configurations with customizable text, background, and borders.

- **Properties**:
  - `text`: `String` = `Sorting`
  - `textColor`: `Color` = `primary`
  - `textFont`: `Font` = `systemsize: 14, weight: .medium`
  - `backgroundColor`: `Color` = `systemBackground`
  - `selectedBackgroundColor`: `Color` = `systemBackground`
  - `imageSize`: `CGSize` = `15x15`
  - `scrolledImageSize`: `CGSize` = `17x17`
  - `borderColor`: `Color` = `gray.opacity0.8`
  - `selectedBorderColor`: `Color` = `orange`
  - `borderWidth`: `CGFloat` = `0.9`
  - `cornerRadius`: `CGFloat` = `18`
  - `minWidth`: `CGFloat` = `50`
  - `defaultWidth`: `CGFloat` = `100`
  - `height`: `CGFloat` = `36`

#### FSStickyFilteringConfig

<img width="103" alt="FSStickyFilteringConfig" src="https://github.com/user-attachments/assets/667470af-554d-419f-80d3-a01dfa4dafa7" />

Configurations for sticky filtering, including badges, icons, text styling, and borders.

- **Properties**:
  - `text`: `String` = `Filtering`
  - `textColor`: `Color` = `.primary`
  - `selectedTextColor`: `Color` = `.primary`
  - `textFont`: `Font` = `.system(size: 14, weight: .medium)`
  - `backgroundColor`: `Color` = `Color(.systemBackground)`
  - `selectedBackgroundColor`: `Color` = `.orange.opacity(0.1)`
  - `image`: `Image` = `Image(systemName: "line.3.horizontal.decrease")`
  - `systemImageForegroundColor`: `Color` = `.orange`
  - `imageSize`: `CGSize` = `CGSize(width: 15, height: 15)`
  - `scrolledImageSize`: `CGSize` = `CGSize(width: 17, height: 17)`
  - `borderColor`: `Color` = `.gray.opacity(0.8)`
  - `selectedBorderColor`: `Color` = `.orange`
  - `borderWidth`: `CGFloat` = `0.9`
  - `cornerRadius`: `CGFloat` = `18`
  - `badgeTextColor`: `Color` = `.white`
  - `badgeBackgroundColor`: `Color` = `.orange`
  - `badgeFont`: `Font` = `.system(size: 9, weight: .medium)`
  - `badgePadding`: `CGFloat` = `5.0`
  - `badgeOffset`: `CGPoint` = `CGPoint(x: -6, y: -6)`
  - `minWidth`: `CGFloat` = `50`
  - `defaultWidth`: `CGFloat` = `100`
  - `height`: `CGFloat` = `36`
    
#### FSPrimaryConfig

<img width="98" alt="FSPrimaryConfig" src="https://github.com/user-attachments/assets/a6870a2e-1696-4c10-97ff-dc1193e97768" />

Styling for primary sections, including text, background, and border properties.

- **Properties**:
  - `backgroundColor`: `Color` = `systemBackground`
  - `selectedBackgroundColor`: `Color` = `cyan.opacity0.05`
  - `textColor`: `Color` = `primary`
  - `selectedTextColor`: `Color` = `blue`
  - `textFont`: `Font` = `systemsize: 14, weight: .medium`
  - `borderColor`: `Color` = `gray.opacity0.8`
  - `selectedBorderColor`: `Color` = `cyan`
  - `borderWidth`: `CGFloat` = `0.7`
  - `cornerRadius`: `CGFloat` = `18`
  - `height`: `CGFloat` = `36`
  - `padding`: `CGFloat` = `12`

#### FSPrimaryToggleConfig

<img width="118" alt="FSPrimaryToggleConfig" src="https://github.com/user-attachments/assets/ddbb2a2a-8b6b-4a34-826b-f3ca9a5e9dc0" />

Customizations for toggleable sections with icons.

- **Properties**:
  - `backgroundColor`: `Color` = `systemBackground`
  - `selectedBackgroundColor`: `Color` = `systemBackground`
  - `textColor`: `Color` = `primary`
  - `selectedTextColor`: `Color` = `primary`
  - `textFont`: `Font` = `systemsize: 14, weight: .medium`
  - `borderColor`: `Color` = `gray.opacity0.8`
  - `selectedBorderColor`: `Color` = `orange`
  - `borderWidth`: `CGFloat` = `0.7`
  - `cornerRadius`: `CGFloat` = `18`
  - `height`: `CGFloat` = `36`
  - `padding`: `CGFloat` = `12`
  - `spacing`: `CGFloat` = `12`
  - `imageSystemName`: `String` = `chevron.up`
  - `imageSize`: `CGSize` = `15x15`

#### FSPrimaryIconConfig

<img width="114" alt="FSPrimaryIconConfig" src="https://github.com/user-attachments/assets/c5d7ad77-7d5e-45ba-9e63-d4a3919f37d1" />

Primary sections with icons.

- **Properties**:
  - `textColor`: `Color` = `primary`
  - `selectedTextColor`: `Color` = `primary`
  - `textFont`: `Font` = `systemsize: 14, weight: .medium`
  - `borderWidth`: `CGFloat` = `0.7`
  - `cornerRadius`: `CGFloat` = `18`
  - `height`: `CGFloat` = `36`
  - `padding`: `CGFloat` = `12`
  - `spacing`: `CGFloat` = `6`
  - `imageSize`: `CGSize` = `15x15`
  - `selectedBackgroundColor`: `Color` = `cyan.opacity0.1`
  - `backgroundColor`: `Color` = `systemBackground`
  - `selectedBorderColor`: `Color` = `cyan`
  - `borderColor`: `Color` = `gray.opacity0.8`

#### FSPrimarySortingConfig

<img width="102" alt="FSPrimarySortingConfig" src="https://github.com/user-attachments/assets/cd9d785f-2958-4c60-9ad2-6cd0f157c7e5" />

Settings for sorting sections.

- **Properties**:
  - `backgroundColor`: `Color` = `systemBackground`
  - `selectedBackgroundColor`: `Color` = `systemBackground`
  - `textColor`: `Color` = `primary`
  - `selectedTextColor`: `Color` = `primary`
  - `textFont`: `Font` = `systemsize: 14, weight: .medium`
  - `borderColor`: `Color` = `gray.opacity0.8`
  - `selectedBorderColor`: `Color` = `orange`
  - `borderWidth`: `CGFloat` = `0.7`
  - `cornerRadius`: `CGFloat` = `18`
  - `height`: `CGFloat` = `36`
  - `padding`: `CGFloat` = `12`

    

#### Notes

- All configurations are optional. Default values are provided for convenience.
- Make sure to call configuration updates in your app's `App` initializer to apply settings globally.


### 📜 License

This framework is provided under the MIT License. Feel free to modify and use it in your projects.

### 🤝 Contributions

Contributions are welcome! If you have ideas or improvements, feel free to:

- Fork the repository.
- Submit a pull request.
- Report issues or feature requests in the Issues tab.

Thank you for contributing! 😊
