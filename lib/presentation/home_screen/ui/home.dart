import 'package:blocwithoutplugin/appexport.dart';
import 'package:blocwithoutplugin/data/model/home_model.dart';
import 'package:blocwithoutplugin/logic/home_bloc.dart';
import 'package:blocwithoutplugin/utils/route_management/navigation_service.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final homeBloc = HomeBloc();
  final _routeService = NavigationService.instance;

  ScrollController controller = ScrollController();

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    homeBloc.loadPosts();
    super.initState();
  }

  @override
  void dispose() {
    print("----dispose--------");

    super.dispose();
  }

  void _scrollListener() {
    print(controller.position.extentAfter);

    if (controller.position.pixels == controller.position.maxScrollExtent) {
      homeBloc.handleRefresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home list',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          GestureDetector(
              onTap: () {
                _routeService.routeTo('/cart');
              },
              child: Icon(Icons.shopping_cart)),
          SizedBox(width: 10,)
        ],
      ),
      body: StreamBuilder<List<HomeModel>>(
        stream: homeBloc.homeController!.stream,
        builder:
            (BuildContext context, AsyncSnapshot<List<HomeModel>> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: homeBloc.handleRefresh,
                    child: ListView.builder(
                      controller: controller,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length + 1,
                      itemBuilder: (context, index) {
                        return index > snapshot.data!.length - 1
                            ? Container(
                                color: Colors.transparent,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : ListTile(
                                title: Text(snapshot.data![index].slug!),
                                subtitle: Text(snapshot.data![index].link!),
                                trailing: GestureDetector(
                                    onTap: () {
                                      homeBloc.addDB(snapshot.data![index]);
                                      homeBloc.showSnack(context);
                                    },
                                    child: Icon(Icons.shopping_cart)),
                              );
                      },
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

  @override
  void deactivate() {
    controller.removeListener(_scrollListener);
    homeBloc.homeController.onPause;
    super.deactivate();
    print("----deactivate--------");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("----reassemble--------");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("----didChangeDependencies--------");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("----didChangeDependencies--------$state");
  }

  @override
  void activate() {
    super.activate();
    print("----activate--------");
  }

  @override
  void didUpdateWidget(MyHomePage state) {
    super.didUpdateWidget(state);
    print("----didUpdateWidget--------");
    print("----didUpdateWidget--------$state");
    // setState(() {
    //   _appLifecycleState = state;
    //   print(_appLifecycleState);
    // });
  }
}
