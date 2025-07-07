# Flutter-specific rules.
# This file is created to prevent issues with code shrinking (minification).

# Don't warn about classes in Flutter's embedding engine.
-dontwarn io.flutter.embedding.android.**

# Keep the Flutter main entry points.
-keep class io.flutter.embedding.android.FlutterActivity
-keep class io.flutter.embedding.android.FlutterFragment
-keep class io.flutter.embedding.android.FlutterView

# Keep all classes in the `io.flutter.plugin.common` package.
-keep class io.flutter.plugin.common.** { *; }

# Keep all classes in the `io.flutter.plugins` package.
-keep class io.flutter.plugins.** { *; }