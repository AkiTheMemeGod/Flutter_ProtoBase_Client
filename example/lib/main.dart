import 'package:flutter/material.dart';
import 'package:proto_base_client/proto_base_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ProtoBaseApiClient client = ProtoBaseApiClient();

  final ProtoBaseDatabaseClient _client = ProtoBaseDatabaseClient();

  final String _apiToken = 'Your Token Here';
  // Replace with your API token
  final String _username = 'Your_Username';
  // Replace with your username
  final String _projectName = 'Spendit';
  // Replace with your project name
  String _response = '';

  void _createTable() async {
    try {
      final result = await _client.createTable(
        _apiToken,
        _username,
        _projectName,
        'test_table',
        ['id', 'name', 'age'],
        ['int', 'text', 'int'],
      );
      setState(() {
        _response = result.toString();
      });
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    }
  }

  void _insertData() async {
    try {
      final result = await _client.insertData(
        _apiToken,
        _username,
        _projectName,
        'test_table',
        {'id': 1, 'name': 'John Doe', 'age': 30},
      );
      setState(() {
        _response = result.toString();
      });
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    }
  }

  void _readData() async {
    try {
      final result = await _client.readData(
        _apiToken,

        _username,
        _projectName,
        'test_table',
      );
      setState(() {
        _response = result.toString();
      });
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    }
  }

  void _updateData() async {
    try {
      final result = await _client.updateData(
        _apiToken,

        _username,
        _projectName,
        'test_table',
        'id = 1',
        {'name': 'Jane Doe', 'age': 25},
      );
      setState(() {
        _response = result.toString();
      });
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    }
  }

  void _deleteData() async {
    try {
      final result = await _client.deleteData(
        _apiToken,
        _username,
        _projectName,
        'test_table',
        'id = 1',
      );
      setState(() {
        _response = result.toString();
      });
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProtoBase Client Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('ProtoBase Client Demo')),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final response = await client.signinWithEmail(
                    'Technoblade',
                    'never',
                    'dies@gmail.com',
                    'UOUuh6m6lv1OeChrtuZQLCY0VyLIv6aniI8mJgNun3y2lmK5DhgOgu98K1Ei33Zhm903FHNfCUv03cQKpJ5BXA',
                  );
                  print(response.toString());
                },
                child: Text('Sign Up'),
              ),

              ElevatedButton(
                onPressed: _createTable,
                child: Text('Create Table'),
              ),
              ElevatedButton(
                onPressed: _insertData,
                child: Text('Insert Data'),
              ),
              ElevatedButton(onPressed: _readData, child: Text('Read Data')),
              ElevatedButton(
                onPressed: _updateData,
                child: Text('Update Data'),
              ),
              ElevatedButton(
                onPressed: _deleteData,
                child: Text('Delete Data'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(_response, style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
