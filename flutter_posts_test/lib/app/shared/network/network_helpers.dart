import 'package:flutter_posts_test/app/shared/network/network_helpers_dio.dart';

abstract class NetworkHelpers {
  factory NetworkHelpers() {
    return NetworkHelpersDio();
  }

  Future<bool> isImageLinkOnline(String url);
}