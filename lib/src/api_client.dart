import 'dart:convert';
import 'package:http/http.dart' as http;

class ProtoBaseClient {
  static const String _baseUrl = 'https://protobase.pythonanywhere.com';

  Future<Map<String, dynamic>> signupWithEmail(
    String username,
    String password,
    String email,
  ) async {
    final url = Uri.parse('$_baseUrl/auth_api/email-signup/');
    final urlWithParams = url.replace(
      queryParameters: {'usr': username, 'pwd': password, 'email': email},
    );
    final response = await http.get(
      urlWithParams,
      headers: {'Content-Type': 'application/json'},
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> signinWithEmail(
    String username,
    String password,
    String email,
  ) async {
    final url = Uri.parse('$_baseUrl/auth_api/email-signin/');
    final urlWithParams = url.replace(
      queryParameters: {'usr': username, 'pwd': password, 'email': email},
    );
    final response = await http.get(
      urlWithParams,
      headers: {'Content-Type': 'application/json'},
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> signupWithUsername(
    String username,
    String password,
  ) async {
    final url = Uri.parse('$_baseUrl/auth_api/user-signup/');
    final urlWithParams = url.replace(
      queryParameters: {'usr': username, 'pwd': password},
    );
    final response = await http.get(
      urlWithParams,
      headers: {'Content-Type': 'application/json'},
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> signinWithUsername(
    String username,
    String password,
  ) async {
    final url = Uri.parse('$_baseUrl/auth_api/user-signin/');
    final urlWithParams = url.replace(
      queryParameters: {'usr': username, 'pwd': password},
    );
    final response = await http.get(
      urlWithParams,
      headers: {'Content-Type': 'application/json'},
    );

    return _handleResponse(response);
  }

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
