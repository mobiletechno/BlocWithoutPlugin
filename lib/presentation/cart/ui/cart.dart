import 'package:blocwithoutplugin/appexport.dart';
import 'package:blocwithoutplugin/data/model/home_model.dart';

import '../../../data/storage/database_helper.dart';
import '../bloc/cart_bloc.dart';
class MyCartPage extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final dbHelper = DatabaseHelper.instance;
  final cartBloc=CartBloc.instance;
  List<HomeModel> _notes = [];

  @override
  void initState() {
    super.initState();
    cartBloc.loadDBlist();
  }

  // void _loadNotes() async {
  //   List<HomeModel> notes = await dbHelper.getAllNotes();
  //   setState(() {
  //     _notes = notes;
  //   });
  // }



  // void _updateNote(int index) async {
  //   HomeModel updatedNote = HomeModel(
  //     id: _notes[index].id,
  //     date:"" ,link:"" ,protected:false ,slug:"" ,
  //   );
  //   await dbHelper.update(updatedNote);
  //   setState(() {
  //     _notes[index] = updatedNote;
  //   });
  // }
  //
  // void _deleteNote(int index) async {
  //   await dbHelper.delete(_notes[index].id!);
  //   setState(() {
  //     _notes.removeAt(index);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart list',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
      ),
      body:  StreamBuilder<List<HomeModel>>(
                    stream: cartBloc.postsController!.stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<HomeModel>> snapshot) {

                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }

                      if (snapshot.hasData) {
                        return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(snapshot.data![index].slug!),
                                        subtitle: Text(snapshot.data![index].link!),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                // _updateNote(index);
                                              },
                                            ),
                                            IconButton

                                              (
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                // _deleteNote(index);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );

                      }
                      return Container(child: Text(""));
                    }));
      }



}