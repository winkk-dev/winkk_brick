# winkk_brick

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A flutter app template to quickly start developing a new winkk app.  

Includes:
* A `main.dart` entrypoint with a `Startup` widget, error handling and instrumentation by `Sentry`, Routing with `go_router_builder`, `riverpod` for state management. Internationalization with `flutter_localization` including a default `/l10n` folder with `app_de.arb`.
* `/values`: Constants and configuration values like `Durations`, `Sizes`, and `ConfigValues`.
* `/styles`: Custom Theming, with light and dark mode, colors, text styles. Easy starting point for adjustments.
* `/utils`: 
  * Extensions for the `BuildContext` so you can write `context.theme` instead of `Theme.of(context)`. `List` extensions, `Navigator` helpers, `Object` extensions which include Kotlin-like `let` and `also` functions. Extension for `Widgets` to easily create a `SliverToBoxAdapter` with `widget.toSliver()`.
  * Handling of external links with `launchUrl` and optionally including `flutter_inAppWebView` setup.
  * `Logger` class with instrumentation for `Sentry`.
  * `Snacks` to easily show Snack-Bars in any point of the app.
  * `ScrollUtils` to fix scroll-to-top behavior in nested `StatefulShellRoutes`.
* `/services` with riverpod providers for device metadata, Dio, Shared Preferences, Sentry.
* `/components` including common widgets we used in other apps such as confetti, error handling, button, etc.
* Setup for launcher icons and splash screen.
* Support for Platforms: iOS, Android, Web, Mac! Linux (without InAppWebView) and Windows also but not tested!

Adding various packages seen in pubspec.yaml. 

## Getting Started 🚀^
After `flutter create` or creating a new app via the IDE:
* Make sure `mason` is installed: `dart pub global activate mason_cli`
* Init mason in your project: `mason init`
* Add this brick: `mason add --git-url https://github.com/winkk-dev/winkk_brick winkk_brick`
* Make the brick: `mason make winkk_brick`

Now you can run your app. If anything failed you can try to run the `make` command again, as it is repeatable.  

If you ever want to re-reun the brick, your original config is saved in `mason_config.json` so run: `mason make winkk_brick -c mason_config.json`

## Next Steps 🛠
* Optionally lock [screen orientation](https://docs.flutter.dev/cookbook/design/orientation#locking-device-orientation)
  * Android: in `android/app/src/main/AndroidManifest.xml` add `android:screenOrientation="portrait"` to the `activity` tag.
  * iOS: in `ìos/Runner.xcworkspace` Runner -> Targets -> General -> Deployment Info -> Device Orientation -> Portrait.
* Adjust the `ConfigValues` in `/values` to your needs.
* Add new entries to the `/l10n/*.arb` files to use them via `context.localizations.anyTextHere`.
  * You should also configure your supported languages in the iOS and Android projects.
* Add new routes to `router/routes.dart` and use them in your app.
* Add new features to `/features`.
* Add Firebase, Supabase or any service connection to a Backend.
* Replace the default icon, configure splash screen and launcher icons.
* Add a font to the `/assets/fonts` folder and include it in the `pubspec.yaml`.

## Mason Documentation 🧱
- [Official Mason Documentation][2]
- [Code generation with Mason Blog][3]
- [Very Good Livestream: Felix Angelov Demos Mason][4]
- [Flutter Package of the Week: Mason][5]
- [Observable Flutter: Building a Mason brick][6]
- [Meet Mason: Flutter Vikings 2022][7]

[1]: https://github.com/felangel/mason
[2]: https://docs.brickhub.dev
[3]: https://verygood.ventures/blog/code-generation-with-mason
[4]: https://youtu.be/G4PTjA6tpTU
[5]: https://youtu.be/qjA0JFiPMnQ
[6]: https://youtu.be/o8B1EfcUisw
[7]: https://youtu.be/LXhgiF5HiQg
