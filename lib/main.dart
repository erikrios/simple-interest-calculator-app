import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interest Calculator',
      home: SimpleInterestCalculator(),
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
      ),
    );
  }
}

class SimpleInterestCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SimpleInterestCalculatorState();
  }
}

class _SimpleInterestCalculatorState extends State<SimpleInterestCalculator> {
  final double _minimumPadding = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: ListView(
        children: <Widget>[
          _getCalculatorLogo(),
        ],
      ),
    );
  }

  Widget _getCalculatorLogo() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage);
    return Container(
      padding: EdgeInsets.only(
        top: _minimumPadding * 5,
        bottom: _minimumPadding * 5,
      ),
      width: 250,
      height: 250,
      child: image,
    );
  }
}
