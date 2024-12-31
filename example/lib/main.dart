import 'package:flutter/material.dart';
import 'package:proto_base_client/proto_base_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ProtoBaseClient client = ProtoBaseClient();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProtoBase Client Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('ProtoBase Client Demo')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final response = await client.signinWithEmail(
                'Technoblade',
                'never',
                'dies@gmail.com',
                'Api Token Here',
              );
              print(response.toString());
            },
            child: Text('Sign Up'),
          ),
        ),
      ),
    );
  }
}
