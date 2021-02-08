import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = ['CAD', 'EUR', 'GBP', 'RUR', 'USD'];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String URL = 'https://min-api.cryptocompare.com/data';
const String APIKEY =
    'e00cf460db84401cdf9b253bb20b40cc90dd580591eb7d0d3600a9512671875b';

class CoinData {
  dynamic _coinData;
  Future<dynamic> fetchCoinData() async {
    String requestURL =
        '$URL/pricemulti?fsyms=BTC,ETH,LTC&tsyms=CAD,GBP,USD,EUR,RUR&api_key=$APIKEY';
    http.Response response = await http.get(requestURL);
    return jsonDecode(response.body);
  }

  void setCoinData(dynamic coinData) {
    _coinData = coinData;
  }

  String getExchangeRate(String currency, String crypto) {
    return _coinData[crypto][currency].toStringAsFixed(0);
  }
}
