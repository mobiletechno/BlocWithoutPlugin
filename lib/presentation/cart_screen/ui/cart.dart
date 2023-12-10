import 'package:blocwithoutplugin/appexport.dart';
import 'package:blocwithoutplugin/logic/cart_bloc.dart';
import 'package:blocwithoutplugin/data/model/home_model.dart';

import '../../../data/storage/database_helper.dart';

class MyCartPage extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final dbHelper = DatabaseHelper.instance;
  final cartBloc=CartBloc();

  @override
  void initState()  {
    super.initState();
     cartBloc.loadDBlist();

  }
  @override
  void dispose() {


    cartBloc.cartController.close();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Cart list',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
      ),
      body:  StreamBuilder<List<HomeModel>>(
                    stream: cartBloc.cartController.stream,
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

                                      );
                                    },
                                  );

                      } else{
                        return Center(child:Container(child: Text("No Data")));
                      }

                    }));
      }



}