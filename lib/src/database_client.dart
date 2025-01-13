import 'dart:convert';
import 'package:http/http.dart' as http;

/// A client for interacting with the ProtoBase API for database operations.
class ProtoBaseDatabaseClient {
  static const String _baseUrl = 'https://protobase.pythonanywhere.com';

  /// Creates a table in the specified project.
  ///
  /// [apiToken] - The API token for authentication.
  /// [username] - The username of the project owner.
  /// [projectName] - The name of the project.
  /// [tableName] - The name of the table to create.
  /// [columns] - A list of column names for the table.
  /// [columnTypes] - A list of corresponding column data types.
  ///
  /// Returns a [Future<Map<String, dynamic>>] containing the response data from the API.
  Future<Map<String, dynamic>> createTable(
    String apiToken,
    String username,
    String projectName,
    String tableName,
    List<String> columns,
    List<String> columnTypes,
  ) async {
    final url = Uri.parse('$_baseUrl/db_api/create_table');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'api_token': apiToken,
        'username': username,
        'project_name': projectName,
        'table_name': tableName,
        'columns': columns,
        'column_types': columnTypes,
      }),
    );

    return _handleResponse(response);
  }

  /// Inserts data into the specified table.
  ///
  /// [apiToken] - The API token for authentication.
  /// [username] - The username of the project owner.
  /// [projectName] - The name of the project.
  /// [table] - The name of the table.
  /// [data] - A map containing the data to insert, where keys are column names and values are column values.
  ///
  /// Returns a [Future<Map<String, dynamic>>] containing the response data from the API.
  Future<Map<String, dynamic>> insertData(
    String apiToken,
    String username,
    String projectName,
    String table,
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse('$_baseUrl/db_api/insert_data');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'api_token': apiToken,
        'username': username,
        'project_name': projectName,
        'table': table,
        'data': data,
      }),
    );

    return _handleResponse(response);
  }

  /// Reads data from the specified table.
  ///
  /// [apiToken] - The API token for authentication.
  /// [username] - The username of the project owner.
  /// [projectName] - The name of the project.
  /// [table] - The name of the table.
  ///
  /// Returns a [Future<Map<String, dynamic>>] containing the response data from the API.
  Future<Map<String, dynamic>> readData(
    String apiToken,
    String username,
    String projectName,
    String table,
  ) async {
    final url = Uri.parse('$_baseUrl/db_api/read_data');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'api_token': apiToken,
        'username': username,
        'project_name': projectName,
        'table': table,
      }),
    );

    return _handleResponse(response);
  }

  /// Updates data in the specified table.
  ///
  /// [apiToken] - The API token for authentication.
  /// [username] - The username of the project owner.
  /// [projectName] - The name of the project.
  /// [table] - The name of the table.
  /// [whereClause] - The condition for updating the data (e.g., 'id = 1').
  /// [updateData] - A map of column names and their new values to update.
  ///
  /// Returns a [Future<Map<String, dynamic>>] containing the response data from the API.
  Future<Map<String, dynamic>> updateData(
    String apiToken,
    String username,
    String projectName,
    String table,
    String whereClause,
    Map<String, dynamic> updateData,
  ) async {
    final url = Uri.parse('$_baseUrl/db_api/update_data');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'api_token': apiToken,
        'username': username,
        'project_name': projectName,
        'table': table,
        'where': whereClause,
        'data': updateData,
      }),
    );

    return _handleResponse(response);
  }

  /// Deletes data from the specified table.
  ///
  /// [apiToken] - The API token for authentication.
  /// [username] - The username of the project owner.
  /// [projectName] - The name of the project.
  /// [table] - The name of the table.
  /// [condition] - The condition for deleting the data (e.g., 'id = 1').
  ///
  /// Returns a [Future<Map<String, dynamic>>] containing the response data from the API.
  Future<Map<String, dynamic>> deleteData(
    String apiToken,
    String username,
    String projectName,
    String table,
    String condition,
  ) async {
    final url = Uri.parse('$_baseUrl/db_api/delete_data');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'api_token': apiToken,
        'username': username,
        'project_name': projectName,
        'table': table,
        'condition': condition,
      }),
    );

    return _handleResponse(response);
  }

  /// Handles the HTTP response and returns the response data as a [Map].
  ///
  /// [response] - The HTTP response from the server.
  ///
  /// Returns a [Map<String, dynamic>] containing the parsed response body if the request is successful.
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
