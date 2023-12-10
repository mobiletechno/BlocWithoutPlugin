import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';

import 'http_service.dart';


class HttpServiceImplementation extends HttpService {
  @override
  void init() {
    // TODO: implement init
  }
  @override
  Future<Response> getRequest(String url) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return response;
  }

  @override
  Future<Response> postObjectRequest(String endPoint, Object jsonobject) {
    // TODO: implement postObjectRequest
    throw UnimplementedError();
  }

  @override
  Future<Response> postRequest(String endPoint, Map<String, dynamic> formdata) {
    // TODO: implement postRequest
    throw UnimplementedError();
  }

  @override
  Future<Response> postW(String url) {
    // TODO: implement postW
    throw UnimplementedError();
  }

  @override
  Future<Response> putRequest(String endPoint, Object jsonobject) {
    // TODO: implement putRequest
    throw UnimplementedError();
  }
}
