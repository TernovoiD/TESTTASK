# Project overview
TESTTASK is an iOS native app built with Swift and SwiftUI on a MVVM architecture.

SCREENCAST: https://streamable.com/3l59fd
Screen recording was made on a real device (iPhone 14 Pro)

1. Configuration options and how to customize them.
   * App is always works in ligth mode as per provided design.
   * App has ukrainian localization (it will be used automatically on devices with unkrainian language as main). Also could be selected manually via built schema (xcode top bar) -> language
2. Dependencies and any external libraries used.
   * Alamofire - The most popular iOS library is used in network layer for API calls.
   * UIKit - Native Apple library is used for camera usage as this functionality is not ported to SwiftUI yet.
3. Troubleshooting tips and common issues.
   * Info.plist file should contain 'Privacy - Camera Usage Description' to allow camera usage.
   * If camera permissions are denied, reset permissions via Settings > Privacy > Camera and re-launch the app.
   * ConnectionMonitor (Module that monitors internet connection) only works on real device, not works on iOS simulator and preview.
4. Instructions on how to build the application.
   * Clone the repository
   * Open the Xcode project
   * Select Apple team (Xcode -> Settings -> Accounts -> Add Apple ID)
   * Ensure camera is allowed (TESTTASK -> Info -> Key 'Privacy - Camera Usage Description')
   * On top bar select real device (must be connected) and press run

     
# Documentation
1. Document any external APIs or libraries used, briefly explaining why you decided to use this API/library.
   * Alamofire is a popular solution to speed up building a network layer. It was especially helpful as provided API ask for new users to be uploaded as mulipart/form-data and this library can handle this easily.
   * UIKit was used to make image selection and camera module. This functionality is not fully portet on SwiftUI and UIKit is a working alternative.
2. Provide a brief overview of the code structure and important modules.
   * Project built with MVVM architecture. This is a modern and commonly used Mobile pattern.
   * Router solution is used for navigation between screens
   * UI is separated into independent modules. Project use reusable elements when possible. UI Models are separated from API Models to make it less dependent on specific server.
   * ConnectionMonitor module is built to track internet connection
   * UserService module is responsible for API calls
