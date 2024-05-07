import 'package:woocommerce/constants/constants.dart';
import 'package:woocommerce/models/jwt_response.dart';
import 'package:woocommerce/src/woo_commerce_client.dart';
import 'package:woocommerce/woocommerce_error.dart';

class WooCommerceAuth {
  final WooCommerceClient _client;

  const WooCommerceAuth({
    required WooCommerceClient client,
  }) : _client = client;

  /// Authenticates the user using WordPress JWT authentication and returns the access [_token] string.
  ///
  /// Associated endpoint : yourwebsite.com/wp-json/jwt-auth/v1/token
  Future authenticateViaJWT({required String username, required String password}) async {
    final body = <String, dynamic>{
      'username': username,
      'password': password,
    };

    final response = await _client.post(
      URL_JWT_TOKEN,
      data: body,
    );

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return WooJWTResponse.fromJson(response.data);
    } else {
      throw WooCommerceError.fromJson(response.data);
    }
  }
}
