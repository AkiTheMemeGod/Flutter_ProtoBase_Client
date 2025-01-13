import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

/// A client for interacting with the ProtoBase API.
class ProtoBaseApiClient {
  static const String _baseUrl = 'https://protobase.pythonanywhere.com/';
  static const _storage = FlutterSecureStorage();
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  /// Signs in a user with the provided [username], [password], [email], and [token].
  ///
  /// On successful sign-in, navigates to the [targetPage] using the provided [context].
  ///
  /// Throws an [Exception] if the sign-in fails.
  Future<void> signinWithEmail(
    String username,
    String password,
    String email,
    String token,
    BuildContext context,
    Widget targetPage,
  ) async {
    final url = Uri.parse('$_baseUrl/auth_api/login/');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'usr': username,
        'pwd': password,
        'email': email,
        'token': token,
      }),
    );

    final data = _handleResponse(response);

    if (data.containsKey('access_token') && data.containsKey('refresh_token')) {
      await _storeTokens(data['access_token'], data['refresh_token']);
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      });
    } else {
      _showError(context, data['error']);
    }
  }

  /// Signs up a user with the provided [username], [password], [email], and [token].
  ///
  /// On successful sign-up, navigates to the [targetPage] using the provided [context].
  ///
  /// Throws an [Exception] if the sign-up fails.
  Future<void> signupWithEmail(
    String username,
    String password,
    String email,
    String token,
    BuildContext context,
    Widget targetPage,
  ) async {
    final url = Uri.parse('$_baseUrl/auth_api/signup/');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'usr': username,
        'pwd': password,
        'email': email,
        'token': token,
      }),
    );

    final data = _handleResponse(response);

    if (data.containsKey('access_token') && data.containsKey('refresh_token')) {
      await _storeTokens(data['access_token'], data['refresh_token']);
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      });
    } else {
      _showError(context, data['error']);
    }
  }

  /// Signs in a user with the provided [username], [password], and [token].
  ///
  /// On successful sign-in, navigates to the [targetPage] using the provided [context].
  ///
  /// Throws an [Exception] if the sign-in fails.
  Future<void> signinWithUsername(
    String username,
    String password,
    String token,
    BuildContext context,
    Widget targetPage,
  ) async {
    final url = Uri.parse('$_baseUrl/auth_api/login/');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'usr': username, 'pwd': password, 'token': token}),
    );

    final data = _handleResponse(response);

    if (data.containsKey('access_token') && data.containsKey('refresh_token')) {
      await _storeTokens(data['access_token'], data['refresh_token']);
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      });
    } else {
      _showError(context, data['error']);
    }
  }

  /// Signs up a user with the provided [username], [password], and [token].
  ///
  /// On successful sign-up, navigates to the [targetPage] using the provided [context].
  ///
  /// Throws an [Exception] if the sign-up fails.
  Future<void> signupWithUsername(
    String username,
    String password,
    String token,
    BuildContext context,
    Widget targetPage,
  ) async {
    final url = Uri.parse('$_baseUrl/auth_api/signup/');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'usr': username, 'pwd': password, 'token': token}),
    );

    final data = _handleResponse(response);

    if (data.containsKey('access_token') && data.containsKey('refresh_token')) {
      await _storeTokens(data['access_token'], data['refresh_token']);
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      });
    } else {
      _showError(context, data['error']);
    }
  }

  /// Stores the [accessToken] and [refreshToken] securely.
  Future<void> _storeTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  /// Handles the HTTP response and returns the decoded JSON data.
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

  /// Shows an error message on the screen.
  void _showError(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(errorMessage)));
  }

  /// Checks the validity of the access token and refreshes it if necessary.
  ///
  /// Throws an [Exception] if the user is not authenticated.
  Future<void> checkAndRefreshToken() async {
    String? accessToken = await _storage.read(key: _accessTokenKey);

    if (accessToken == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/auth_api/verify-token/'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 401) {
      await _refreshAccessToken();
    }
  }

  /// Refreshes the access token using the refresh token.
  ///
  /// Throws an [Exception] if the refresh token is not found or the refresh fails.
  Future<void> _refreshAccessToken() async {
    final refreshToken = await _storage.read(key: _refreshTokenKey);
    if (refreshToken == null) {
      throw Exception('No refresh token found');
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/auth_api/refresh/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh_token': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['access_token'];
      await _storage.write(key: _accessTokenKey, value: newAccessToken);
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  /// Signs out the user by clearing the stored tokens and navigating to the [targetPage].
  Future<void> signOut(BuildContext context, Widget targetPage) async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }
}
