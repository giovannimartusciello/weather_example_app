import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        weak var registrar = self.registrar(forPlugin: "webview")

        let factory = FLNativeViewFactory(messenger: registrar!.messenger())
        registrar!.register(
            factory,
            withId: "webview")
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
