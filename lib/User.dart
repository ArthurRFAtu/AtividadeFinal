import 'package:flutter/foundation.dart';

class UserData extends ChangeNotifier {
  List<Map<String, dynamic>> _users = [];

  List<Map<String, dynamic>> get users => _users;

  void addUser(Map<String, dynamic> user) {
    _users.add(user);
    notifyListeners();
  }
}
