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
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Phone Number Input'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              PhoneNumberField(
                controller: PhoneNumberEditingController.fromCountryCode('AZ'),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 24),
              PhoneNumberFormField(
                autovalidateMode: AutovalidateMode.always,
                controller: PhoneNumberEditingController.fromCountryCode('TR'),
                decoration: InputDecoration(border: UnderlineInputBorder()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
