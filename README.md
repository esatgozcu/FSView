# FSView - SwiftUI Sorting & Filtering Component

FSView is a versatile and intuitive SwiftUI component designed to streamline **sorting** and **filtering** operations in your applications. It provides users with a seamless interface to sort and filter products or items effortlessly.

---

![Ekran Kaydı 2025-01-30 08 50 56](https://github.com/user-attachments/assets/562905da-7866-455c-a70b-45da6219f0b9)

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

General settings for spacing and scroll background.

- **Properties**:
  - `spacing`: `CGFloat` = `5`
  - `scrollBackground`: `Color` = `systemBackground`

#### FSStickyConfig

Settings for sticky headers, including height, padding, and divider properties.

- **Properties**:
  - `backgroundColor`: `Color` = `systemBackground`
  - `dividerHeight`: `CGFloat` = `36`
  - `dividerColor`: `Color` = `separator`
  - `height`: `CGFloat` = `40`
  - `padding`: `CGFloat` = `10`
  - `spacing`: `CGFloat` = `10`

#### FSPrimaryConfig

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

#### FSStickySortingConfig

Sticky sorting configurations with badge support.

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

Configurations for sticky filtering, including badges and icons.

- **Properties**:
  - `text`: `String` = `Filtering`
  - `badgeTextColor`: `Color` = `white`
  - `badgeBackgroundColor`: `Color` = `orange`
  - `badgeFont`: `Font` = `systemsize: 9, weight: .medium`
  - `badgePadding`: `CGFloat` = `5.0`
  - `badgeOffset`: `CGPoint` = `-6, -6`
  - `minWidth`: `CGFloat` = `50`
  - `defaultWidth`: `CGFloat` = `100`
  - `height`: `CGFloat` = `36`

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
