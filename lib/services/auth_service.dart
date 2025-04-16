// lib/services/auth_service.dart
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  final String _baseUrl = 'http://10.0.2.2:5000/api';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _token;
  Map<String, dynamic>? _user;

  bool get isAuth => _token != null;
  String? get token => _token;
  Map<String, dynamic>? get user => _user;

  Future<void> autoLogin() async {
    try {
      final token = await _storage.read(key: 'token');
      if (token != null) {
        _token = token;
        final response = await http.get(
          Uri.parse('$_baseUrl/user'),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          _user = json.decode(response.body);
          notifyListeners();
        } else {
          await logout();
        }
      }
    } catch (error) {
      await logout();
    }
  }

  Future<void> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    final responseData = json.decode(response.body);
    if (response.statusCode != 201) {
      throw HttpException(responseData['message']);
    }

    _token = responseData['token'];
    _user = responseData['user'];
    await _storage.write(key: 'token', value: _token);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    final responseData = json.decode(response.body);
    if (response.statusCode != 200) {
      throw HttpException(responseData['message']);
    }

    _token = responseData['token'];
    _user = responseData['user'];
    await _storage.write(key: 'token', value: _token);
    notifyListeners();
  }

  Future<void> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
      }),
    );

    final responseData = json.decode(response.body);
    if (response.statusCode != 200) {
      throw HttpException(responseData['message']);
    }
  }

  Future<void> logout() async {
    _token = null;
    _user = null;
    await _storage.delete(key: 'token');
    notifyListeners();
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() {
    return message;
  }
}