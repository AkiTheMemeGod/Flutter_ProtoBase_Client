import 'dart:convert';
import 'package:http/http.dart' as http;

/// A client for interacting with the ProtoBase API.
///
/// This client provides methods for signing up and signing in using email or username.
class ProtoBaseClient {
  static const String _baseUrl = 'https://protobase.pythonanywhere.com';

  /// Signs up a user using their email, username, password, and token.
  ///
  /// Returns a [Future] that completes with a [Map] containing the response data.
  ///
  /// Throws an [Exception] if the sign-up fails.
  Future<Map<String, dynamic>> signupWithEmail(
    String username,
    String password,
    String email,
    String token,
  ) async {
    final url = Uri.parse('$_baseUrl/auth_api/email-signup/');
    final urlWithParams = url.replace(
      queryParameters: {
        'usr': username,
        'pwd': password,
        'email': email,
        'token': token,
      },
    );
    final response = await http.get(
      urlWithParams,
      headers: {'Content-Type': 'application/json'},
    );

    return _handleResponse(response);
  }

  /// Signs in a user using their email, username, password, and token.
  ///
  /// Returns a [Future] that completes with a [Map] containing the response data.
  ///
  /// Throws an [Exception] if the sign-in fails.
  Future<Map<String, dynamic>> signinWithEmail(
    String username,
    String password,
    String email,
    String token,
  ) async {
    final url = Uri.parse('$_baseUrl/auth_api/email-signin/');
    final urlWithParams = url.replace(
      queryParameters: {
        'usr': username,
        'pwd': password,
        'email': email,
        'token': token,
      },
    );
    final response = await http.get(
      urlWithParams,
      headers: {'Content-Type': 'application/json'},
    );

    return _handleResponse(response);
  }

  /// Signs up a user using their username, password, and token.
  ///
  /// Returns a [Future] that completes with a [Map] containing the response data.
  ///
  /// Throws an [Exception] if the sign-up fails.
  Future<Map<String, dynamic>> signupWithUsername(
    String username,
    String password,
    String token,
  ) async {
    final url = Uri.parse('$_baseUrl/auth_api/user-signup/');
    final urlWithParams = url.replace(
      queryParameters: {'usr': username, 'pwd': password, 'token': token},
    );
    final response = await http.get(
      urlWithParams,
      headers: {'Content-Type': 'application/json'},
    );

    return _handleResponse(response);
  }

  /// Signs in a user using their username, password, and token.
  ///
  /// Returns a [Future] that completes with a [Map] containing the response data.
  ///
  /// Throws an [Exception] if the sign-in fails.
  Future<Map<String, dynamic>> signinWithUsername(
    String username,
    String password,
    String token,
  ) async {
    final url = Uri.parse('$_baseUrl/auth_api/user-signin/');
    final urlWithParams = url.replace(
      queryParameters: {'usr': username, 'pwd': password, 'token': token},
    );
    final response = await http.get(
      urlWithParams,
      headers: {'Content-Type': 'application/json'},
    );

    return _handleResponse(response);
  }

  /// Handles the HTTP response and returns the response data as a [Map].
  ///
  /// Throws an [Exception] if the response status code is not 200.
  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {
        'error': 'Failed to connect to API',
        'statusCode': response.statusCode,
      };
    }
  }
}
