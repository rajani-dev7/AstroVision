## Overview
AstroVision is an iOS app built using Swift and SwiftUI that displays NASA's Astronomy Picture of the Day (APOD). It uses the NASA APOD API to fetch the image (or video) along with its title and explanation for the selected date.

# AstroVision Application

## Features
## Basic Functionality
1.Shows today's APOD (image or video) on app launch.
2.Supports date selection to load APOD for any specific day.
3.Handles both image and video content types.
4.Caches the last successful APOD response (image + data) to show offline if network fails.

## Bonus Enhancements:
1.Full support for iPhone and iPad (portrait + landscape).
2.Dark Mode compatibility.
3.Dynamic Type for accessibility.

## Architecture:
1.The app follows MVVM with clean separation of:
  Model: APOD.swift
  ViewModel: APODViewModel.swift, MediaViewModel.swift
  Views: SwiftUI-based components using a TabView layout.
  Network Layer: Custom-built client in NetworkClient/ (no third-party libraries used).

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
APODView: Displays the image or embedded video for the selected date.
MainTabView: Hosts different screens using a TabView.
APODDateContentView: Allows date selection and triggers fetch.

## Tech Specs:
Minimum iOS Version: iOS 16.0
Language: Swift
Frameworks: SwiftUI, Foundation
No third-party dependencies

## Tests:
Unit tests included under AstroVisionTests/
UI tests under AstroVisionUITests/

## Screenshots:
![home](https://github.com/user-attachments/assets/426a32a5-1674-4c95-8621-9f47bd1ce956)

![date_Picker](https://github.com/user-attachments/assets/ce45eac1-8973-47c5-af2c-daee472ea915)

![video_apod](https://github.com/user-attachments/assets/0b59331d-4ae1-4400-a114-91186095e3ed)
