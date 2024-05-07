import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:woocommerce/constants/constants.dart';
import 'package:woocommerce/src/word_press_api.dart';
import 'package:woocommerce/woocommerce_error.dart';

class WooCommerceOptions {
  /// Parameter [consumerKey] is the consumer key provided by WooCommerce, e.g. `ck_12abc34n56j`.
  final String consumerKey;

  /// Parameter [consumerSecret] is the consumer secret provided by WooCommerce, e.g. `cs_1uab8h3s3op`.
  final String consumerSecret;

  /// Parameter(Optional) [apiPath], tells the SDK if there is a different path to your api installation.
  /// Useful if the websites woocommerce api path have been modified.
  final String apiPath;

  const WooCommerceOptions({
    required this.consumerKey,
    required this.consumerSecret,
    this.apiPath = URL_STORE_API_PATH,
  });
}

class WooCommerceClient with DioMixin {
  final WordPressOptions wordPressOptions;
  final WooCommerceOptions wooCommerceOptions;

  // /// Returns if the website is https or not based on the [baseUrl] parameter.
  // final bool isHttps; this.isHttps = baseUrl.startsWith("https")

  String? token;

  WooCommerceClient({
    required this.wordPressOptions,
    required this.wooCommerceOptions,
  }) {
    options = BaseOptions(
      baseUrl: '${wordPressOptions.baseUrl}/${wooCommerceOptions.apiPath}',
      headers: {
        'consumer_key': wooCommerceOptions.consumerKey,
        'consumer_secret': wooCommerceOptions.consumerSecret,
      },
    );
  }

  Exception _handleDioError(Response response) {
    switch (response.statusCode) {
      case 400:
      case 401:
      case 404:
      case 500:
        throw Exception(WooCommerceError.fromJson(json.decode(response.data)).toString());
      default:
        throw Exception("An error occurred, status code: ${response.statusCode}");
    }
  }

  dynamic _handleError(dynamic response) {
    if (response['message'] == null) {
      return response;
    } else {
      throw Exception(WooCommerceError.fromJson(response).toString());
    }
  }

  @override
  Future<Response<T>> fetch<T>(RequestOptions requestOptions) async {
    if (token != null) {
      requestOptions = requestOptions.copyWith(
        headers: {
          'Authorization': 'Bearer $token',
          ...requestOptions.headers,
        },
      );
    }

    try {
      return await super.fetch(requestOptions);
    } on DioError catch (error) {
      throw _handleDioError(error.response!);
    }
  }
}

/// This Generates a valid OAuth 1.0 URL
///
/// if [isHttps] is true we just return the URL with
/// [consumerKey] and [consumerSecret] as query parameters
class WooCommerceAuthenticator extends Interceptor {
  final String consumerKey;
  final String consumerSecret;

  WooCommerceAuthenticator({
    required this.consumerKey,
    required this.consumerSecret,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options = options.copyWith(
      headers: {
        ...options.headers,
        'consumer_key': consumerKey,
        'consumer_secret': consumerSecret,
      },
    );
    super.onRequest(options, handler);
  }
}

class QueryString {
  /// Parses the given query string into a Map.
  static Map parse(String query) {
    RegExp search = RegExp('([^&=]+)=?([^&]*)');
    Map result = Map();

    // Get rid off the beginning ? in query strings.
    if (query.startsWith('?')) query = query.substring(1);

    // A custom decoder.
    decode(String s) => Uri.decodeComponent(s.replaceAll('+', ' '));

    // Go through all the matches and build the result map.
    for (Match match in search.allMatches(query)) {
      result[decode(match.group(1)!)] = decode(match.group(2)!);
    }

    return result;
  }
}
