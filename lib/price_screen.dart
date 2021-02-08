import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'CAD';
  CoinData coinData = CoinData();
  Map<String, String> rate = {};

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          rate = updateRate();
        });
      },
    );
  }

  Map<String, String> updateRate() {
    cryptoList.forEach((element) {
      rate[element] = coinData.getExchangeRate(selectedCurrency, element);
    });
    return rate;
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(
        currency,
        style: TextStyle(color: Colors.white),
      ));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          rate = updateRate();
        });
      },
      children: pickerItems,
    );
  }

  void getData() async {
    try {
      coinData.setCoinData(await coinData.fetchCoinData());
      setState(() {
        rate = updateRate();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    cryptoList.forEach((element) {
      rate[element] = '?';
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ReusableCard(
                  rate: rate["BTC"], selectedCurrency: selectedCurrency),
              ReusableCard(
                  rate: rate["ETH"], selectedCurrency: selectedCurrency),
              ReusableCard(
                  rate: rate["LTC"], selectedCurrency: selectedCurrency),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            // child: Platform.isIOS ? iOSPicker() : androidDropdown(),
            child: iOSPicker(),
          ),
        ],
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    Key key,
    @required this.rate,
    @required this.selectedCurrency,
  }) : super(key: key);

  final String rate;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            '1 BTC = $rate $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
