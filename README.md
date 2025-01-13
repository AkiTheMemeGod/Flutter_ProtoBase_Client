# ProtoBase Client

ProtoBase Client is a simple and lightweight Dart package designed to help developers integrate authentication and database functionalities with ease. It provides methods for signing up and signing in using email or username through the ProtoBase API, as well as methods for database operations.

## Features

- **Email-Based Authentication**:
  - Sign up using email, password, and username.
  - Sign in using email, password, and username.

- **Username-Based Authentication**:
  - Sign up using a username and password.
  - Sign in using a username and password.
  
- **API Token-Based Usage**:
  - Obtain your API key from the [official website](https://protobase.pythonanywhere.com/).
  - Use the API key to authenticate your requests.

- **Database Operations**:
  - Create tables.
  - Insert data into tables.
  - Read data from tables.
  - Update data in tables.
  - Delete data from tables.

## Installation

Add the following to your `pubspec.yaml` file:
```yaml
dependencies:
  proto_base_client: ^2.0.0
```

Run `flutter pub get` to install the package.

## Usage

```dart
import 'package:proto_base_client/proto_base_client.dart';

void main() async {
  final client = ProtoBaseApiClient();
  final dbClient = ProtoBaseDatabaseClient();
  
  // Example usage for authentication
  final signupResponse = await client.signupWithEmail(
    'username',
    'password',
    'email@example.com',
    'api_token',
  );
  print(signupResponse);

  // Example usage for database operations
  final createTableResponse = await dbClient.createTable(
    'api_token',
    'username',
    'project_name',
    'table_name',
    ['column1', 'column2'],
    ['type1', 'type2'],
  );
  print(createTableResponse);
}
```

## API Endpoints

This package interacts with the following API endpoints:
- `/auth_api/email-signup/`
- `/auth_api/email-signin/`
- `/auth_api/user-signup/`
- `/auth_api/user-signin/`
- `/api/create_table`
- `/api/insert_data`
- `/api/read_data`
- `/api/update_data`
- `/api/delete_data`

## License

This package is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

