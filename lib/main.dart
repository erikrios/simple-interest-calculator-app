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
  final double _minimumPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Container(
        margin: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget>[
            _getCalculatorLogo(),
            _getTextField(
              labelText: 'Principal',
              hintText: 'Enter Principal e.g. 12000',
            ),
            _getTextField(
              labelText: 'Rate of interest',
              hintText: 'In percent',
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _minimumPadding,
                bottom: _minimumPadding,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getCalculatorLogo() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      margin: EdgeInsets.all(
        _minimumPadding * 5,
      ),
      child: image,
    );
  }

  Widget _getTextField({String labelText, String hintText}) {
    return Padding(
      padding: EdgeInsets.only(
        top: _minimumPadding,
        bottom: _minimumPadding,
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
