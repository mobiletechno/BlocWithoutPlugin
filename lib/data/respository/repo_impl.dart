import 'dart:async';

import 'dart:convert' as convert;

import 'package:blocwithoutplugin/data/respository/repo.dart';

import '../../appconfig/constant.dart';
import '../webservice/http_service.dart';
import '../webservice/http_service_impl.dart';
class RepoImpl implements Repo {
   HttpService _httpService=HttpServiceImplementation();

  RepoImpl() {
    this._httpService.init();
  }

  @override
  Future<dynamic> getList(int pagination) async {
    try {
      final response = await _httpService.getRequest(
          "${Constant.BASEURL}?per_page=$pagination&context=embed");


      if (response.statusCode == 200) {
        var jsonResponse =
        convert.jsonDecode(response.body);
        return jsonResponse;
      }
    } on Exception catch (e) {}


  }
}
