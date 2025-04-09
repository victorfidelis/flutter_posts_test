import 'package:flutter_posts_test/app/shared/network/network_helpers.dart';
import 'package:dio/dio.dart';

class NetworkHelpersDio implements NetworkHelpers {  
  @override
  Future<bool> isImageLinkOnline(String url) async {
    try {
      final dio = Dio();
      final response = await dio.head(url);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}