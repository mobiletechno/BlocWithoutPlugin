
import 'package:blocwithoutplugin/appexport.dart';
import 'package:blocwithoutplugin/homescreen/model/home_model.dart';

import '../../data/respository/repo.dart';
import '../../data/respository/repo_impl.dart';
class HomeBloc{
  Repo _repo=RepoImpl();
  StreamController<List<Homemodel>> postsController=  StreamController();
  int count = 1;

  Future<List<Homemodel>> fetchPost([howMany = 10]) async {

    final apiResult=await _repo.getList(howMany);
    if(apiResult!=null){
      final List<dynamic> rawData = apiResult;
      final parsed =
      rawData.map((e) => Homemodel.fromJson(e)).toList();
      print("parsed[0].date");
      print(parsed[0].date);
      print("parsed[0].date");
      return parsed;

    } else{
      return[];
    }
  }

  loadPosts() async {
    fetchPost().then((res) async {
      postsController!.add(res);
      return res;
    });
  }

  showSnack() {
    // return ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('New content loaded'),
    //   ),
    // );
  }


  Future<void> handleRefresh() async {
    count++;
    print(count);
    fetchPost(count * 10).then((res) async {

      postsController!.add(res);
      // showSnack();

    });
  }


}