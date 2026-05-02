import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/country.dart';
import 'api_exception.dart';

class CountryApiService {
  final String _baseUrl = 'restcountries.com';
  final Duration _timeout = const Duration(seconds: 10);

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  void _checkResponse(http.Response response) {
    if (response.statusCode != 200) {
      throw ApiException('Failed request', response.statusCode);
    }
  }

  Future<List<Country>> fetchAllCountries() async {
    try {
      final uri = Uri.https(_baseUrl, '/v3.1/all', {
        'fields': 'name,flag,region,population,cca3',
      });

      final response = await http.get(uri, headers: _headers).timeout(_timeout);

      _checkResponse(response);

      final List data = jsonDecode(response.body);

      return data.map((e) => Country.fromJson(e)).toList();
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Request timed out');
    } on FormatException {
      throw Exception('Unexpected data format received');
    }
  }

  Future<List<Country>> searchByName(String name) async {
    final uri = Uri.https(_baseUrl, '/v3.1/name/$name');

    final response = await http.get(uri, headers: _headers).timeout(_timeout);

    _checkResponse(response);

    final List data = jsonDecode(response.body);

    return data.map((e) => Country.fromJson(e)).toList();
  }

  Future<Country> fetchByCode(String code) async {
    final uri = Uri.https(_baseUrl, '/v3.1/alpha/$code');

    final response = await http.get(uri, headers: _headers).timeout(_timeout);

    _checkResponse(response);

    final List data = jsonDecode(response.body);

    return Country.fromJson(data[0]);
  }
}
