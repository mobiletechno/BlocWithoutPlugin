
import 'package:blocwithoutplugin/appexport.dart';
import 'package:blocwithoutplugin/data/respository/repo_impl.dart';
import 'package:blocwithoutplugin/data/model/home_model.dart';
import 'package:blocwithoutplugin/data/storage/database_helper.dart';

import '../../../data/respository/repo.dart';


class CartBloc{
  CartBloc._privateConstructor();
  static final CartBloc instance = CartBloc._privateConstructor();
  final dbHelper = DatabaseHelper.instance;
  StreamController<List<HomeModel>> postsController=  StreamController();

  void loadDBlist() async {
    List<HomeModel> homeList = await dbHelper.getAllNotes();
    postsController.add(homeList);


  }



  void _updateNote(int index) async {
    // HomeModel updatedNote = HomeModel(
    //   id: _notes[index].id,
    //   date:"" ,link:"" ,protected:false ,slug:"" ,
    // );
    // await dbHelper.update(updatedNote);
    //
    //   _notes[index] = updatedNote;

  }

  void _deleteNote(int index) async {
    // await dbHelper.delete(_notes[index].id!);
    //
    //   _notes.removeAt(index);

  }

}