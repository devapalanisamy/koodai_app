import 'package:http/http.dart';

abstract class IRestClient {
  Future<Response> get(String path,
      {bool isAuthenticationRequired, Map<String, String> parameters});
  Future<Response> post(String path, String request,
      {bool isAuthenticationRequired});
  Future<Response> delete(String path, {bool isAuthenticationRequired});
  Future<Response> put(String path, String request,
      {bool isAuthenticationRequired});
}
