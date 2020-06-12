import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureServices {
  final _storage = FlutterSecureStorage();

  Future readSavedPassword() async {
    try {
      String _savedPassword = await _storage.read(key: 'savedPassword');
      return _savedPassword;
    } catch (e) {
      return null;
    }
  }

  Future writeNewPassword(newPassword) async {
    _storage.write(key: 'savedPassword', value: newPassword);
  }
}
