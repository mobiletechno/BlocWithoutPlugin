import 'package:blocwithoutplugin/appexport.dart';
import 'package:blocwithoutplugin/homescreen/model/home_model.dart';

import '../bloc/homebloc.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeBloc homeBloc=HomeBloc();
  ScrollController controller=ScrollController();

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    homeBloc.loadPosts();
    super.initState();
  }
  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }
  void _scrollListener() {
    print(controller.position.extentAfter);


    if (controller.position.pixels ==
        controller.position.maxScrollExtent) {
  print("----triggered");
      homeBloc.handleRefresh();
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar:  AppBar(
        title:  Text('StreamBuilder'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Refresh',
            icon: Icon(Icons.refresh),
            onPressed: homeBloc.handleRefresh,
          )
        ],
      ),
      body: StreamBuilder<List<Homemodel>>(
        stream: homeBloc.postsController!.stream,
        builder: (BuildContext context, AsyncSnapshot<List<Homemodel>> snapshot) {
          print('Has error: ${snapshot.hasError}');
          print('Has data: ${snapshot.hasData}');
          print('Snapshot Data ${snapshot.data}');

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: Scrollbar(
                    child: RefreshIndicator(
                      onRefresh: homeBloc.handleRefresh,
                      child:ListView.builder(
                        controller: controller,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount:   snapshot.data!.length+1,
                        itemBuilder: (context, index) {


                          return
                            index > snapshot.data!.length-1  ?
                            Container(
                              color: Colors.transparent,
                              child: Center(child: CircularProgressIndicator()),
                            )
                                :

                            ListTile(
                            title: Text(snapshot.data![index].slug!),
                            subtitle: Text(snapshot.data![index].link!),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Text('No Posts');
          }
          return SizedBox();
        },

      ),
    );
  }
}