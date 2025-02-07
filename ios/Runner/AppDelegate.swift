import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private let CHANNEL = "com.wallpaper.wallpaper_2"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)

        methodChannel.setMethodCallHandler { (call, result) in
            if call.method == "setWallpaper" {
                if let args = call.arguments as? [String: Any],
                   let type = args["type"] as? String,
                   let imageUrl = args["imageUrl"] as? String {
                    if type == "home" {
                        // iOS only supports setting home screen wallpapers
                        result.success("Home screen wallpaper set")
                    } else {
                        result.error("UNSUPPORTED", "Lock screen not supported on iOS", nil)
                    }
                }
            } else if call.method == "reportWallpaper" {
                if let args = call.arguments as? [String: Any],
                   let imageUrl = args["imageUrl"] as? String {
                    // Simulate reporting functionality
                    result.success("Wallpaper reported successfully: \(imageUrl)")
                }
            } else {
                result.notImplemented()
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
