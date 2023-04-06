import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refresher/MyAppState.dart';

class Login extends StatelessWidget {
  final String defaulturl;
  Login({required this.defaulturl});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();
    bool _active = false;

    return Center(
      child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/images/logo.png'),
                const SizedBox(height: 16.0),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'QR-FAIRY',
                    style: TextStyle(
                      fontSize:
                          24, // change this value to increase or decrease the font size
                      fontWeight: FontWeight
                          .bold, // you can also set other font styles here
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'LOG IN',
                    style: TextStyle(
                      fontSize:
                          18, // change this value to increase or decrease the font size
                      fontWeight: FontWeight
                          .normal, // you can also set other font styles here
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Log in to do bulk qr-codes or keep track of codes generated.',
                    textAlign: TextAlign.center,
                  ),
                ]),
              ],
            ),
            const SizedBox(height: 120.0),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Username/Email',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 12.0),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                MaterialButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                ),
                ElevatedButton(
                  child: const Text('NEXT'),
                  onPressed: appState.isLoading
                      ? null
                      : () {
                          var user = _usernameController.value.text;
                          appState.loginUser(
                              _usernameController.value.text,
                              _passwordController.value.text,
                              defaulturl,
                              context);
                          _usernameController.clear();
                          _passwordController.clear();

                          appState.saveUserName(user);
                        },
                ),
              ],
            ),
          ]),
    );
  }
}
