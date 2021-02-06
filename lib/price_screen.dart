import 'package:crypto_tracker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  DropdownButton<String> androidDropdown() {
    return DropdownButton<String>(
      value: currency,
      onChanged: (String selectedCurrency) {
        setState(() {
          currency = selectedCurrency;
        });
      },
      items: currenciesList
          .map<DropdownMenuItem<String>>(
              (String item) => DropdownMenuItem<String>(
                    child: Text(item),
                    value: item,
                  ))
          .toList(),
    );
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      children: currenciesList.map((item) => Text(item)).toList(),
      onSelectedItemChanged: (selectedIndex) {},
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
    );
  }

  String currency = currenciesList[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Tracker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
