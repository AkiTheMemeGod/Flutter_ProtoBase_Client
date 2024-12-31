
# ProtoBase Client

ProtoBase Client is a simple and lightweight Dart package designed to help developers integrate authentication functionalities with ease. It provides methods for signing up and signing in using email or username through the ProtoBase API.

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

## Installation

Add the following to your `pubspec.yaml` file:
```yaml
dependencies:
  proto_base_client: ^1.0.1-dev
```

Run `flutter pub get` to install the package.

## Usage

```dart
import 'package:proto_base_client/proto_base_client.dart';

void main() async {
  final client = ProtoBaseClient();

  // Sign up using email
  final signupResponse = await client.signupWithEmail(
    'john_doe',
    'securepassword123',
    'john.doe@example.com',
    'Api Token Here',
  );
  print(signupResponse);

  // Sign in using email
  final signinResponse = await client.signinWithEmail(
    'john_doe',
    'securepassword123',
    'john.doe@example.com',
    'Api Token Here',

  );
  print(signinResponse);
}
```

## API Endpoints

This package interacts with the following API endpoints:
- `/auth_api/email-signup/`
- `/auth_api/email-signin/`
- `/auth_api/user-signup/`
- `/auth_api/user-signin/`

## License

This package is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

