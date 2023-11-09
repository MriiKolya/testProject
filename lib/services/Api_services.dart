// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  Future<int> createPost(String name, String email, String message) async {
    Map<String, dynamic> request = {
      "name": name,
      "email": email,
      "message": message
    };
    final uri = Uri.parse('https://api.byteplex.info/api/test/contact/');
    String jsonData = json.encode(request);
    final response = await http.post(
      uri,
      body: jsonData,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    return response.statusCode;
  }
}
