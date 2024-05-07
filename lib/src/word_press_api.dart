import 'package:dio/dio.dart';
import 'package:woocommerce/constants/constants.dart';
import 'package:woocommerce/models/customer.dart';

class WordPressOptions {
  /// Parameter, [baseUrl] is the base url of your site. For example, http://me.com or https://me.com.
  final String baseUrl;

  const WordPressOptions({
    required this.baseUrl,
  });
}

class WordPressClient with DioMixin {
  WordPressClient({
    required WordPressOptions options,
  }) {
    this.options = BaseOptions(
      baseUrl: '${options.baseUrl}/$DEFAULT_WC_API_PATH',
    );
  }
}

class WordPressApi {
  final Dio _client;

  /// Creates a new Woocommerce Customer and returns the customer object.
  ///
  /// Accepts a customer object as required parameter.
  Future<WooCustomer> createCustomer(WooCustomer customer) async {
    final response = await _client.post('customers', data: customer.toJson());
    _printToLog('created customer : ' + response.toString());
    return WooCustomer.fromJson(response);
  }
}
