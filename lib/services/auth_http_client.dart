import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_storage.dart';

Future<Map<String, String>> _buildAuthHeaders(
    {Map<String, String>? extra}) async {
  final token = await AuthStorage.getAccessToken();
  final headers = <String, String>{
    'Content-Type': 'application/json',
    if (extra != null) ...extra,
  };
  if (token != null) {
    headers['Authorization'] = 'Bearer $token';
  }
  return headers;
}

Future<http.Response> authPost(
  Uri uri, {
  Map<String, String>? headers,
  Object? body,
}) async {
  final mergedHeaders = await _buildAuthHeaders(extra: headers);
  return http.post(uri, headers: mergedHeaders, body: body);
}

Future<http.Response> authGet(
  Uri uri, {
  Map<String, String>? headers,
}) async {
  final mergedHeaders = await _buildAuthHeaders(extra: headers);
  return http.get(uri, headers: mergedHeaders);
}

