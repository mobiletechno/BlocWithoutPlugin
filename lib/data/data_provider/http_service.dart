import 'package:http/http.dart';

abstract class HttpService {
  void init();

  Future<Response> getRequest(String url);

  Future<Response> postObjectRequest(String endPoint, Object jsonobject);

  Future<Response> postRequest(String endPoint, Map<String, dynamic> formdata);

  Future<Response> postW(String url);

  Future<Response> putRequest(String endPoint, Object jsonobject);
}
