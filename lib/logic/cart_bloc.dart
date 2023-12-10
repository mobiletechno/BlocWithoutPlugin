
import 'package:blocwithoutplugin/appexport.dart';
import 'package:blocwithoutplugin/data/respository/repo_impl.dart';
import 'package:blocwithoutplugin/data/model/home_model.dart';
import 'package:blocwithoutplugin/data/storage/database_helper.dart';

import '../../../data/respository/repo.dart';


class CartBloc{

  final dbHelper = DatabaseHelper.instance;
  StreamController<List<HomeModel>> cartController=  StreamController();

 void loadDBlist() async {
    List<HomeModel> homeList = await dbHelper.getAllNotes();
      cartController.add(homeList);


  }


}