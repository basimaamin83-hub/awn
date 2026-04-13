/// إعدادات خرائط Google. استبدل المفاتيح في:
/// - `web/index.html` (سكربت JavaScript)
/// - `android/app/src/main/AndroidManifest.xml` (meta-data)
/// - `ios/Runner/AppDelegate.swift` (GMSServices)
abstract final class MapsConfig {
  /// مركز افتراضي (عمان) عند تعذّر جلب الموقع.
  static const double defaultLat = 31.9539;
  static const double defaultLng = 35.9106;
}
