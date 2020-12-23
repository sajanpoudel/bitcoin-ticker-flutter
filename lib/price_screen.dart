import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
 

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  
 String coinType = 'AUD';

  DropdownButton<String> androidDropDownItems() {
    List<DropdownMenuItem<String>> dropdown = [];
    for (var currency in currenciesList) {
      var dropdow = DropdownMenuItem(child: Text(currency), value: currency);
      dropdown.add(dropdow);
    }

    return DropdownButton<String>(
      items: dropdown,
      value: coinType,
      onChanged: (value) {
        setState(() {
           coinType = value;
        
          urlMessage();
         
      
          
          
        });
      },
      hint: Text('Cryptocurrency'),
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> currencyListv = [];
    for (var currency in currenciesList) {
      var text = Text(
        currency,
        style: TextStyle(color: Colors.white),
      );
      currencyListv.add(text);
    }
    return CupertinoPicker(
        itemExtent: 50.0,
        onSelectedItemChanged: (selectedIndex) {
          urlMessage();
          coinType= coinType;
          print(selectedIndex);
        },
        children: currencyListv);
  }

String bitcoinValue='?';
String ethValue = '?';
String ltcValue ='?';


  void urlMessage()async{
    
try{
  Map rate = await CoinData(coinType: coinType).getApiDecodedMessage();
     setState(() {
       bitcoinValue = rate['BTC'];
       ethValue = rate['ETH'];
       ltcValue =rate['LTC'];

     });
     }
     catch(e){
print(e);
     }

   
  }
    @override
  void initState(){
    super.initState();
    urlMessage();
  
  }

  @override
  Widget build(BuildContext context) {
    print(bitcoinValue);
   
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[Column(children:[
          CoinPad(coinValue: bitcoinValue, coinType: coinType, crypto: 'BTC',),
          CoinPad(coinValue: ltcValue, coinType: coinType, crypto: 'LTC',),
          CoinPad(coinValue: ethValue, coinType: coinType,crypto: 'ETH',),
        ]),
          
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS?iosPicker():androidDropDownItems(),
          ),
        ],
      ),
    );
  }
}

class CoinPad extends StatelessWidget {
  const CoinPad({
    Key key,
    @required this.coinValue,
    @required this.coinType,
    this.crypto,
  }) : super(key: key);

  final String coinValue;
  final String coinType;
  final String crypto;

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
            
            '1 $crypto = $coinValue $coinType',
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
