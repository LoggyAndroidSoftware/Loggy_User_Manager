import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loggy_administrator/model/user.dart';
import 'package:loggy_administrator/model/line.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  List<User> _users = [
    User(name: 'John Doe', email: 'john@gmail.com', password: '123', line: 'Linea 1'),
    User(name: 'Marc Doe', email: 'marc@gmail.com', password: '123', line: 'Linea 1'),
    User(name: 'Marco', email: 'marco@gmail.com', password: '123', line: 'Linea 1'),
    User(name: 'Jesus', email: 'jesus@gmail.com', password: '123', line: 'Linea 1')
  ];

  List<User> get users => _users;

  List<Line> _lines = [];

  List<Line> get lines => _lines;

  Future<void> addUser(User user) async {
    _users.add(user);
    notifyListeners();
  }

  Future<void> updateUser(User updatedUser) async {
    int index = _users.indexWhere((user) => user.email == updatedUser.email);
    if (index != -1) {
      _users[index] = updatedUser;
      notifyListeners();
    }
  }

  Future<void> deleteUser(String email) async {
    _users.removeWhere((user) => user.email == email);
    notifyListeners();
  }

  Future<void> fetchLines() async {
    try {
      final response = await http.get(Uri.parse('https://jubilant-delight-production.up.railway.app/api/v4/lines'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _lines = data.map((json) => Line.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load lines');
      }
    } catch (e) {
      print('Error fetching lines: $e');
      throw e;
    }
  }
}
