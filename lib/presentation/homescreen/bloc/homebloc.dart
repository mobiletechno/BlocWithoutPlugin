
import 'package:blocwithoutplugin/appexport.dart';
import 'package:blocwithoutplugin/data/model/home_model.dart';
import 'package:blocwithoutplugin/data/respository/repo.dart';

import 'package:blocwithoutplugin/data/respository/repo_impl.dart';
import 'package:blocwithoutplugin/data/storage/database_helper.dart';


class HomeBloc{
  HomeBloc._privateConstructor();
  static final HomeBloc instance = HomeBloc._privateConstructor();
  final dbHelper = DatabaseHelper.instance;

  Repo _repo=RepoImpl();
  StreamController<List<HomeModel>> postsController=  StreamController();
  int count = 1;

  Future<List<HomeModel>> fetchPost([howMany = 10]) async {

    final apiResult=await _repo.getList(howMany);
    if(apiResult!=null){
      final List<dynamic> rawData = apiResult;
      final parsed =
      rawData.map((e) => HomeModel.fromJson(e)).toList();
      return parsed;

    } else{
      return[];
    }
  }
  void addDB(HomeModel homeModel) async {
    HomeModel newhomeModel = HomeModel(
        id:homeModel.id ,
        date:homeModel.date ,link:homeModel.link ,protected:homeModel.protected ,slug:homeModel.slug,type: homeModel.type

    );
    int id = await dbHelper.insert(newhomeModel);
    // int id = await dbHelper.insert(newNote);

    homeModel.id = id;

    // _notes.add(newNote);

  }
  loadPosts() async {
    fetchPost().then((res) async {
      postsController!.add(res);
      return res;
    });
  }

  showSnack(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('added in cart'),
      ),
    );
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