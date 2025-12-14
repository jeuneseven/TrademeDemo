# Trade Me iOS App

A native iOS application that displays the latest listings from Trade Me, New Zealand's leading online marketplace. This project demonstrates modern iOS development practices with SwiftUI, MVVM architecture, and comprehensive testing.

## Features

- **Latest Listings Display**: Browse the latest 20 listings with images, locations, titles, and pricing
- **Price Logic**: Smart price display for auction and classified listings with optional "Buy Now" prices
- **Search & Cart**: Placeholder navigation for search and shopping cart functionality
- **Tab Navigation**: Easy navigation between Discover, Notifications, Watchlist, and My Trade Me tabs
- **Error Handling**: Graceful error handling with retry mechanism
- **Accessibility**: Full VoiceOver support with labels, hints, and identifiers

## Architecture

The project follows MVVM (Model-View-ViewModel) architecture:

- **Models**: `LatestListItem`, `LatestListResponse` - Data structures for listings
- **ViewModels**: `LatestListViewModel`, `LatestListItemViewModel` - Business logic and state management
- **Views**: `LatestListView`, `LatestListItemView`, `OtherTabView` - SwiftUI UI components
- **Services**: `DiscoverService`, `DefaultDiscoverService`, `MockDiscoverService` - API layer with dependency injection

## Tech Stack

- **Language**: Swift
- **UI Framework**: SwiftUI
- **State Management**: @Observable (Swift 5.10+)
- **Testing**: XCTest with Swift Testing
- **Network**: URLSession with OAuth 1.0 authentication
- **Minimum iOS**: iOS 16.0+

## Project Structure

```
├── Models/
│   ├── LatestListItem.swift
│   ├── LatestListResponse.swift
│   └── APIError.swift
├── ViewModels/
│   ├── LatestListViewModel.swift
│   └── LatestListItemViewModel.swift
├── Views/
│   ├── ContentView.swift
│   ├── LatestListView.swift
│   ├── LatestListItemView.swift
│   └── OtherTabView.swift
├── Services/
│   ├── DiscoverService.swift
│   ├── DefaultDiscoverService.swift
│   └── MockDiscoverService.swift
├── Resources/
│   ├── Constants.swift
│   └── SampleData.json
└── Tests/
    ├── LatestListViewModelTests.swift
    ├── LatestListItemViewModelTests.swift
    ├── LatestListItemTests.swift
    ├── APIErrorTests.swift
    ├── LatestListViewUITests.swift
    └── TradeMeDemoUITests.swift
```

## Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 16.0+
- Swift 6.0+

### Build & Run
1. Clone the repository
2. Open `TradeMeDemo.xcodeproj` in Xcode
3. Build and run on simulator or device

### Run Tests
```bash
# Unit Tests
Cmd + U

# UI Tests
Cmd + U (select UI test target)
```
## Testing

The project includes comprehensive test coverage:

- **Unit Tests**: 679+ lines covering ViewModels, Models, and Error handling
- **UI Tests**: Integration tests for navigation and user interactions
- **Mock Service**: Test data loading from `SampleData.json`

### Test Coverage
- LatestListItemViewModel: 11 tests
- LatestListViewModel: 6 tests
- LatestListItem Model: 8 tests
- APIError: 6 tests
- UI Integration: 10+ tests

## Design System

Uses Trade Me's design tokens:

| Color | Hex Code |
|-------|----------|
| Tasman Blue | #148FE2 |
| Feijoa Green | #29A754 |
| Text Dark | #393531 |
| Text Light | #85807B |

Spacing and sizing constants defined in `Constants.swift` for consistency.

## Key Implementation Details

### State Management
- Uses `@Observable` macro for reactive UI updates
- Enums for state representation (idle, loading, loaded, error)

### Error Handling
- Custom `APIError` enum with detailed error descriptions
- Retry mechanism in ViewModel
- User-friendly error messages

### Accessibility
- All interactive elements have labels and identifiers
- Proper use of accessibility traits
- VoiceOver support for screen readers

## Future Enhancements

- Implement real search functionality
- Shopping cart management
- Watchlist persistence
- Detailed listing view
- Image caching optimization
- Infinite scroll pagination
- Namespace
- Dark Mode
- Network(Cache)
- VIPER/Clean
- Refresh/Loadmore
- SwiftLint
- CI/CD

## License

This project was created as part of the Trade Me mobile technical test.
