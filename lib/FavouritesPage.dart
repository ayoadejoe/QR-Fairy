import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:refresher/MyAppState.dart';

class FavouritesPage extends StatelessWidget {
  final String defaulturl;
  FavouritesPage({required this.defaulturl});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var selectedFav = appState.favorites;

    if (selectedFav.isEmpty) {
      return Center(
        child: Text('No favourites selected yet'),
      );
    }

    return ListView(
      //automatically scrolls
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('You have ${selectedFav.length} saved qr codes '),
        ),
        for (var word in selectedFav)
          ListTile(
            leading: QrImage(
              data: word,
              size: 150.0, // width and height of the QR code
            ),
            title: Text(word),
            onTap: () {
              print(word);
            },
          ),
      ],
    );

    return Column(children: [
      Text('Selected'),
      for (var selected in selectedFav) Text(selected.asPascalCase),
    ]);
  }
}
