## Overview
AstroVision is an iOS app built using Swift and SwiftUI that displays NASA's Astronomy Picture of the Day (APOD). It uses the NASA APOD API to fetch the image (or video) along with its title and explanation for the selected date.

# AstroVision Application

## Features
## Basic Functionality
* Shows today's APOD (image or video) on app launch.
* Supports date selection to load APOD for any specific day.
* Handles both image and video content types.
* Caches the last successful APOD response (image + data) to show offline if network fails.

## Bonus Enhancements:
* Full support for iPhone and iPad (portrait + landscape).
* Dark Mode compatibility.
* Dynamic Type for accessibility.

## Architecture:
The app follows MVVM with clean separation of:
* Model: APOD.swift
* ViewModel: APODViewModel.swift, MediaViewModel.swift
* Views: SwiftUI-based components using a TabView layout.
* Network Layer: Custom-built client in NetworkClient/ (no third-party libraries used).

## Project Structure

```
AstroVision/
├── AstroVision.xcodeproj/         # Xcode project files
├── AstroVision/                   # App source code
│   ├── AstroVisionApp.swift       # App entry point
│   ├── Model/
│   │   └── APOD.swift             # APOD model
│   ├── View/                      # SwiftUI views
│   │   ├── MainTabView.swift
│   │   ├── APODView.swift
│   │   ├── APODContentView.swift
│   │   ├── APODDateContentView.swift
│   │   └── MediaView.swift
│   ├── ViewModel/
│   │   ├── APODViewModel.swift
│   │   └── MediaViewModel.swift
│   ├── NetworkClient/            # Network layer
│   │   ├── APODUrlService.swift
│   │   ├── NetworkService.swift
│   │   ├── HTTPMethod.swift
│   │   ├── URLConfiguration.swift
│   │   └── APIClientError.swift
│   ├── Util/
│   │   ├── Configs/
│   │   │   └── Config.json       # API key setup
│   │   ├── Extensions/
│   │   │   ├── URLRequest+Extension.swift
│   │   │   └── View+Extension.swift
│   │   ├── MediaType.swift
│   │   └── WebView.swift         # Video support
│   ├── Assets.xcassets/          # Colors and app icon
│   └── Preview Content/
├── Screenshots/                  # (Create this folder for images used in README)
├── AstroVisionTests/             # Unit tests
│   └── AstroVisionTests.swift
├── AstroVisionUITests/           # UI tests
│   ├── AstroVisionUITests.swift
│   └── AstroVisionUITestsLaunchTests.swift
├── README.md
└── LICENSE

```


## Screens:
* APODView: Displays the image or embedded video for the selected date.
* MainTabView: Hosts different screens using a TabView.
* APODDateContentView: Allows date selection and triggers fetch.

## Tech Specs:
* Minimum iOS Version: iOS 16.0
* Language: Swift
* Frameworks: SwiftUI, Foundation
* No third-party dependencies

## Tests:
* Unit tests included under AstroVisionTests/
* UI tests under AstroVisionUITests/

## Screenshots:
![home](https://github.com/user-attachments/assets/426a32a5-1674-4c95-8621-9f47bd1ce956)

![date_Picker](https://github.com/user-attachments/assets/ce45eac1-8973-47c5-af2c-daee472ea915)

![video_apod](https://github.com/user-attachments/assets/0b59331d-4ae1-4400-a114-91186095e3ed)


## ✅ Enhancement Points:

- **Add Favorites Feature**  
  Let users bookmark their favorite APODs locally using `CoreData` or `UserDefaults`.

- **Offline Storage of Multiple APODs**  
  Persist recent APODs (not just the last one) using local database or file caching.

- **Share Functionality**  
  Allow sharing APOD image or video via native `UIActivityViewController`.

- **Improve Network Layer**  
  - Use `async/await` for cleaner code  
  - Add retry logic and better error handling  
  - Use dependency injection for easier testing

- **Search by Concept Tags**  
  If available in API, add tag-based search and filtering.

- **Add Skeleton Loading View**  
  Show shimmer/skeleton loaders while fetching content.

- **Full-Screen Viewer**  
  Tap to view APOD image or video in full screen with zoom support.

- **Unit & UI Test Coverage**  
  - Add snapshot tests  
  - Mock network layer for unit testing  
  - Measure test coverage

- **CI/CD with GitHub Actions or Fastlane**  
  Automate build, test, and deployment to TestFlight.

- **Accessibility Improvements**  
  Support VoiceOver, Dynamic Type scaling, and accessibility labels.

- **UI Enhancements**  
  - Smooth animations when switching dates  
  - Theming and layout improvements  
  - Onboarding/tutorial screen

- **Analytics & Crash Reporting**  
  Integrate Firebase Analytics and Crashlytics to monitor usage and issues.


