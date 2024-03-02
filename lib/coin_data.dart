import 'package:bitcoin_ticker/networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const apiKey = '49E7DC17-8DC9-4704-B3E9-F4F5AEB09472';
const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate/';

class CoinData {
  String? currency;
  String? crypto;
  CoinData({this.currency, this.crypto});

  Future<dynamic> getCoinData() async {
    String url = '$coinApiUrl$crypto/$currency?apikey=$apiKey';
    NetworkHelper netHelp = NetworkHelper(url);

    var weatherData = await netHelp.getData();
    return weatherData;
  }
}
