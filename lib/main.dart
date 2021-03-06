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
        brightness: Brightness.dark,
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
  var _formKey = GlobalKey<FormState>();
  final double _minimumPadding = 5.0;
  final List<String> _currencies = [
    'Rupiah',
    'Dollars',
    'Ringgit',
    'Yuan',
    'Dirham'
  ];
  String _currentCurrency;
  String _result = "";

  @override
  void initState() {
    super.initState();
    _currentCurrency = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(_minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              _getCalculatorLogo(),
              _getTextFormField(
                labelText: 'Principal',
                hintText: 'Enter Principal e.g. 12000',
                textStyle: textStyle,
                controller: principalController,
                validatorMessage: 'Please enter principal amount',
              ),
              _getTextFormField(
                labelText: 'Rate of interest',
                hintText: 'In percent',
                textStyle: textStyle,
                controller: roiController,
                validatorMessage: 'Please enter rate of interest',
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: _minimumPadding,
                  bottom: _minimumPadding,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _getTextFormField(
                        labelText: 'Term',
                        hintText: 'Time in years',
                        textStyle: textStyle,
                        controller: termController,
                        validatorMessage: 'Please enter time',
                      ),
                    ),
                    Container(
                      width: _minimumPadding * 5,
                    ),
                    Expanded(
                      child: _getDropdownButton(),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _getRaisedButton(
                      buttonText: 'Calculate',
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      onPressedHandler: () {
                        if (_formKey.currentState.validate())
                          _result = _calculateTotalResult();
                      },
                    ),
                  ),
                  Expanded(
                    child: _getRaisedButton(
                      buttonText: 'Reset',
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      onPressedHandler: () => _reset(),
                    ),
                  ),
                ],
              ),
              _getResultText(),
            ],
          ),
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
        _minimumPadding * 10,
      ),
      child: image,
    );
  }

  Widget _getTextFormField(
      {String labelText,
      String hintText,
      TextStyle textStyle,
      TextEditingController controller,
      String validatorMessage}) {
    return Padding(
      padding: EdgeInsets.only(
        top: _minimumPadding,
        bottom: _minimumPadding,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          errorStyle: TextStyle(color: Colors.yellowAccent),
        ),
        style: textStyle,
        validator: (String value) {
          if (value.isEmpty) return validatorMessage;
        },
      ),
    );
  }

  Widget _getDropdownButton() {
    return DropdownButton(
      value: _currentCurrency,
      items: _currencies.map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String value) {
        setState(() {
          _currentCurrency = value;
        });
      },
    );
  }

  Widget _getRaisedButton(
      {String buttonText = 'Button',
      Color color,
      Color textColor,
      Function onPressedHandler}) {
    return Padding(
      padding: EdgeInsets.only(
        top: _minimumPadding,
        bottom: _minimumPadding,
      ),
      child: RaisedButton(
        child: Text(
          buttonText,
          textScaleFactor: 1.5,
        ),
        onPressed: () {
          setState(() {
            onPressedHandler();
          });
        },
        color: color,
        textColor: textColor,
      ),
    );
  }

  Widget _getResultText() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(_minimumPadding * 2),
        child: Text(_result),
      ),
    );
  }

  String _calculateTotalResult() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        'After $term years, your investment will be worth $totalAmountPayable $_currentCurrency';
    return result;
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    _result = "";
    _currentCurrency = _currencies[0];
  }
}
