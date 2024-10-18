import 'package:x_amap_base/x_amap_base.dart';

class ConstConfig {
  static const AMapApiKey amapApiKeys = AMapApiKey(
      androidKey: '924d1353ea34a96761f2e040c224e445',
      iosKey: '4dfdec97b7bf0b8c13e94777103015a9');
  static const AMapPrivacyStatement amapPrivacyStatement =
      AMapPrivacyStatement(hasContains: true, hasShow: true, hasAgree: true);
}
