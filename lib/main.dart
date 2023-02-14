import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:refresher/post_model.dart';
import 'http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:refresher/MyAppState.dart';
import 'package:refresher/Registration.dart';
import 'package:refresher/FavouritesPage.dart';
import 'package:refresher/GeneratorPage.dart';

//My main page
void main() {
  runApp(
      const QRFairy(),
  );
}

//Starting point
class QRFairy extends StatelessWidget {
  const QRFairy({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Naming App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(
              40, 157, 7, 0.7607843137254902)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;
  bool _registered = false;
  var _username;

  final String _regKey = "regkey";
  final String _userKey = "userkey";
  late SharedPreferences _prefs;

  Future<void> _makeRestfulCall(var url) async {
    print('Checking for user');
    var data = await makeRestfulCall(url);
    setState(() {
      print('Checking done');
      Post post = data as Post;
      print(post.clientID);
      print(post.empty);
      if(post.newuser != null){
        selectedIndex = 2;
      }else{
        selectedIndex = 0;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        // load the audio setting from the SharedPreferences
        _registered = _prefs.getBool(_regKey) ?? false;
        _username = _prefs.getString(_userKey) ?? '';
        print('username retrieved:${_username}');
      });
    });
    var url = Uri.parse('http://54.175.240.234/registeredclient?clientName=${_username}');
    if(_registered == false) {
      _makeRestfulCall(url); // call the fetch data method when the page launches
    }
  }

  @override
  Widget build(BuildContext context) {
    //var appState = context.watch<MyAppState>();
    Widget page;

    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
      page = FavouritesPage();
      break;
      case 2:
        page = Registration();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(

                child:
                NavigationRail(

                  extended: constraints.maxWidth>=500,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.qr_code),
                      label: Text('Favorites'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.add),
                      label: Text('Add New'),
                    ),
                  ],

                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),

              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
          resizeToAvoidBottomInset: true,
        );

      }
    );
  }
}


void showToast(BuildContext context, String notice, String label) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(notice),
      action: SnackBarAction(label: label, onPressed: scaffold.hideCurrentSnackBar),
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      elevation: 10.0,
    ),
  );
}

