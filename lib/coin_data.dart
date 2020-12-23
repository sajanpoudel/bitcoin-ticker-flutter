import 'package:http/http.dart';
import 'dart:convert';
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


const String kApiKey ='4C413DD6-EA92-4F3C-AC86-4792031EE9F1';

class CoinData {
  CoinData({this.coinType});
  final String coinType;


  Future <Map> getApiDecodedMessage()async {
    Map<String,String> cryptoPrice = {};
    for (String crypto in cryptoList){
      Response response = await get('https://rest.coinapi.io/v1/exchangerate/$crypto/$coinType?apikey=$kApiKey');
       if(response.statusCode == 200){
         var message = response.body;
           var decodedUrl = jsonDecode(message)['rate'];
           cryptoPrice[crypto] = decodedUrl.toStringAsFixed(5);
           

       }
       else{
         print(response.statusCode);
       }
    }
print(cryptoPrice);
return cryptoPrice;

}
}
