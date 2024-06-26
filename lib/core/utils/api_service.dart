import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// The ApiService class for making HTTP GET, POST, and DELETE requests
class ApiService {
  // Base URL for the Google Books API
  final String _baseUrl;

  String? token;
  // Dio instance used for making HTTP requests
  final Dio _dio;

  // Constructor to initialize the ApiService with a Dio instance
  ApiService(this._dio, this._baseUrl);

  // Asynchronous function to make a GET request to the API
  Future<dynamic> get({required String endPoint}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('auth-token') == null) {
      prefs.setString('auth-token', '');
    }
    token = prefs.getString('auth-token');

    // Send a GET request to the specified endPoint by combining it with the base URL
    try {
      var response = await _dio.get(
        '$_baseUrl$endPoint',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      return Future.error(e.toString());
    }

    // Return the response data as a map (dynamic) containing key-value pairs
  }

  // Asynchronous function to make a POST request to the API
  Future<dynamic> add(
      {required String endPoint, required Map<String, dynamic> data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('auth-token') == null) {
      prefs.setString('auth-token', '');
    }
    token = prefs.getString('auth-token');

    // Send a POST request to the specified endPoint by combining it with the base URL
    try {
      var response = await _dio.post(
        '$_baseUrl$endPoint',
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );

      // Return the response data as a map (dynamic) containing key-value pairs
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to add data');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Asynchronous function to make a POST request to the API
  Future<dynamic> edit({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('auth-token') == null) {
      prefs.setString('auth-token', '');
    }
    token = prefs.getString('auth-token');

    // Send a POST request to the specified endPoint by combining it with the base URL
    try {
      var response = await _dio.put(
        '$_baseUrl$endPoint',
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );

      // Return the response data as a map (dynamic) containing key-value pairs
      if (response.statusCode == 200) {
        if (response.data == false) {
          return {'status': 'failure', 'message': 'Operation failed'};
        }
        return response.data;
      } else {
        throw Exception('Failed to edit data');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Asynchronous function to make a DELETE request to the API
  Future<dynamic> delete({required String endPoint}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('auth-token') == null) {
      prefs.setString('auth-token', '');
    }
    token = prefs.getString('auth-token');

    // Send a DELETE request to the specified endPoint by combining it with the base URL
    try {
      var response = await _dio.delete(
        '$_baseUrl$endPoint',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );

      // Return the response data as a map (dynamic) containing key-value pairs
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 404) {
        return {'status': 'error', 'message': 'Doctor not found'};
      } else if (response.data == false) {
        return {'status': 'failure', 'message': 'Operation failed'};
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
