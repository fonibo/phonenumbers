import 'package:flutter/material.dart';
import 'package:phonenumbers/phonenumbers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Phone Number Input'),
        ),
        body: Column(
          children: <Widget>[
            PhoneNumberInput(),
          ],
        ),
      ),
    );
  }
}
