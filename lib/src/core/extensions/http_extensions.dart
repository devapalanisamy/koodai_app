import 'package:http/http.dart';

extension HttpResponseExtension on Response {
  bool get success {
    if (this.statusCode >= 200 && this.statusCode < 300) return true;
    return false;
  }
}
