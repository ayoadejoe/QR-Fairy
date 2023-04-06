import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:refresher/MyAppState.dart';

import 'main.dart';

class GeneratorPage extends StatelessWidget {
  final String defaulturl;
  GeneratorPage({required this.defaulturl});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var newWord = appState.current;
    final _qrcodeController = TextEditingController();
    IconData icon;
    if (appState.favorites.contains(newWord)) {
      icon = Icons.save;
    } else {
      icon = Icons.save_as_outlined;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logowe.png'),
          const SizedBox(height: 1.0),
          const Text('QR-FAIRY'),
          const SizedBox(height: 6.0),
          QrImage(
            data: newWord,
            size: 200.0, // width and height of the QR code
          ),
          const SizedBox(height: 26.0),
          Card(
            elevation: 50,
            shadowColor: Color.fromARGB(244, 204, 64, 64),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _qrcodeController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Enter: address, url, item location',
                ),
              ),
            ),
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton2(appState: appState, icon: icon),
              ElevatedButton(
                onPressed: () {
                  String val = _qrcodeController.value.text;
                  appState.getNext(val);
                  String trunc = val;
                  if (val.length > 10) trunc = val.substring(0, 10);
                  showToast(context, trunc + ' generated', "FAIRY");
                }, //Action
                child: Text('Generate'),
              ),
            ],
          ), //created this by extracting to flutter widget
        ], //Children
      ),
    );
  }
}

class TextButton2 extends StatelessWidget {
  const TextButton2({
    super.key,
    required this.appState,
    required this.icon,
  });

  final MyAppState appState;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton.icon(
        onPressed: () {
          appState.toggleFavorite();
        }, //Action
        icon: Icon(icon),
        label: Text('Save'),
      ),
    );
  }
}
