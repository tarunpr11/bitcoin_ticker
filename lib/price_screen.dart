import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'INR';
  dynamic BTCPrice = '?';
  dynamic ETHPrice = '?';
  dynamic LTCPrice = '?';
  @override
  void initState() {
    // TODO: implement initState
    getCoinData();
    super.initState();
  }

  void getCoinData() {
    CoinData BTCPrice = CoinData(crypto: 'BTC', currency: selectedCurrency);
    var BTCData = BTCPrice.getCoinData();
    CoinData ETHPrice = CoinData(crypto: 'ETH', currency: selectedCurrency);
    var ETHData = ETHPrice.getCoinData();
    CoinData LTCPrice = CoinData(crypto: 'LTC', currency: selectedCurrency);
    var LTCData = LTCPrice.getCoinData();
    updateUI(BTCData, ETHData, LTCData);
    return;
  }

  void updateUI(dynamic BTCData, dynamic ETHData, dynamic LTCData) async {
    dynamic BTCPriceData = await BTCData;
    double BTCprice = await BTCPriceData['rate'];
    dynamic ETHPriceData = await ETHData;
    double ETHprice = await ETHPriceData['rate'];
    dynamic LTCPriceData = await LTCData;
    double LTCprice = await LTCPriceData['rate'];
    setState(() {
      BTCPrice = BTCprice.toInt();
      ETHPrice = ETHprice.toInt();
      LTCPrice = LTCprice.toInt();
    });
  }

  DropdownButton androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        getCoinData();
      },
    );
  }

  Widget iOSPicker() {
    List<Widget> currencyList = [];

    for (String currency in currenciesList) {
      currencyList.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: currencyList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $BTCPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $ETHPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $LTCPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 150.0,
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 30.0),
        color: Colors.lightBlue,
        child: Platform.isIOS ? iOSPicker() : androidDropDown(),
      ),
    );
  }
}
