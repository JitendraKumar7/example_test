import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

ApiClient get api => ApiClient();

class ApiClient {
  final _base = 'https://dog.ceo/api';

  Future<String> getBreed() async {
    try {
      //https://dog.ceo/api/breeds/list/all
      var response = await http.get(Uri.parse('$_base/breeds/list/all'));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      return response.body;
    } catch (e) {
      throw e;
    }
  }

  Future<String> getBreedImages(String breed) async {
    try {
      //https://dog.ceo/api/breed/affenpinscher/images
      var response = await http.get(Uri.parse('$_base/breed/$breed/images'));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      return response.body;
    } catch (e) {
      throw e;
    }
  }
}
