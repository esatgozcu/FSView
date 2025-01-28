# FSView - SwiftUI Sorting & Filtering Component

FSView is a versatile and intuitive SwiftUI component designed to streamline **sorting** and **filtering** operations in your applications. It provides users with a seamless interface to sort and filter products or items effortlessly.



## 🚀 Features

- **Dynamic Visibility**:
  - Sorting and filtering panels dynamically open and close based on user interaction.
- **Customizable UI**:
  - Toggle View: Allows multi-selection for categories, brands, and similar items.
  - Icon-based Filtering: Includes visually distinct options for specific filters.
- **Built with SwiftUI**:
  - Fully utilizes SwiftUI's animations and modern view-building principles.



## 📦 Swift Package Manager

CustomTextfield is available through [Swift Package Manager](https://swift.org/package-manager/). Add CustomTextField as a dependency to your `Package.swift`:

```Swift
.package(url: "https://github.com/esatgozcu/FSView", from: "main")
```



## 🛠️ Usage

Here’s a sample implementation of **FSView**:

```swift
import FSView

struct ContentView: View {
    @State private var sortingItems: [SortingItemModel] = [
        SortingItemModel(title: "Recommended", isSelected: true, isDefault: true),
        SortingItemModel(title: "Most Expensive"),
        SortingItemModel(title: "Cheapest"),
        SortingItemModel(title: "Top Selling"),
        SortingItemModel(title: "Most Rated", isPrimary: true)
    ]

    @State private var filteringItems: [FilteringItemModel] = [
        FilteringItemModel(title: "In Stock", isPrimary: false),
        FilteringItemModel(
            title: "Categories",
            isPrimary: true,
            type: .toggle([
                PrimaryToggleModel(title: "Shoes"),
                PrimaryToggleModel(title: "Clothing"),
                PrimaryToggleModel(title: "Sports")
            ])
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

## 💡 Customization

### Updating Configurations

`FSMainConfig` uses a singleton approach, making it accessible throughout your app:
```swift
let config = FSMainConfig.shared
```

#### Example:

```swift
@main
struct FSViewApp: App {
    init() {
        configureUI()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    private func configureUI() {
        // FSView general configuration
        FSMainConfig.shared.updateFsViewConfig { config in
            config.spacing = 10
            config.scrollBackground = Color.gray.opacity(0.1)
        }

        // Sticky section configuration
        FSMainConfig.shared.updateFsStickConfig { config in
            config.dividerColor = .red
            config.height = 50
        }

        // Primary section configuration
        FSMainConfig.shared.updateFsPrimaryConfig { config in
            config.textColor = .blue
            config.borderWidth = 1.0
            config.cornerRadius = 20
        }
    }
}
```



### Configuration Sections

#### FSViewConfig
General settings for spacing and scroll background.
- **Properties**:
  - `spacing`: `CGFloat`
  - `scrollBackground`: `Color`



#### FSStickyConfig
Settings for sticky headers (e.g., height, padding, and divider color).
- **Properties**:
  - `dividerHeight`: `CGFloat`
  - `dividerColor`: `Color`
  - `height`: `CGFloat`
  - `padding`: `CGFloat`



#### FSPrimaryConfig
Styling for primary sections (e.g., text, background, and border).
- **Properties**:
  - `textColor`: `Color`
  - `selectedTextColor`: `Color`
  - `borderColor`: `Color`
  - `cornerRadius`: `CGFloat`



#### FSPrimaryToggleConfig
Customizations for toggleable sections with icons.
- **Properties**:
  - `imageSystemName`: `String`
  - `imageSize`: `CGSize`
  - `spacing`: `CGFloat`



#### FSPrimaryIconConfig
Primary sections with icons (e.g., icon size, spacing).
- **Properties**:
  - `imageSize`: `CGSize`
  - `spacing`: `CGFloat`



#### FSPrimarySortingConfig
Settings for sorting sections.
- **Properties**:
  - `selectedBackgroundColor`: `Color`
  - `cornerRadius`: `CGFloat`


#### FSStickySortingConfig
Sticky sorting configurations with badge support.
- **Properties**:
  - `text`: `String`
  - `imageSize`: `CGSize`
  - `badgeTextColor`: `Color`



#### FSStickyFilteringConfig
Configurations for sticky filtering, including badges and icons.
- **Properties**:
  - `badgeFont`: `Font`
  - `badgeBackgroundColor`: `Color`
  - `badgeOffset`: `CGPoint`



### Notes

- All configurations are optional. Default values are provided for convenience.
- Use SwiftUI's `Color` and `Font` to ensure seamless integration.
- Make sure to call configuration updates in your app's `App` initializer to apply settings globally.



## 📜 License

This framework is provided under the MIT License. Feel free to modify and use it in your projects.

## 🤝 Contributions

Contributions are welcome! If you have ideas or improvements, feel free to:

- Fork the repository.
- Submit a pull request.
- Report issues or feature requests in the Issues tab.

Thank you for contributing! 😊
