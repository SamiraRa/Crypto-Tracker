import 'package:crypto_tracking_app/models/latest_coin_model.dart';
import 'package:crypto_tracking_app/services/data_providers.dart';
import 'package:http/http.dart' as http;

class Repositories {
  Future<LatestCoin> latestCoinRepo(
      String start, String limit, String convert) async {
    LatestCoin latestCoinData;

    try {
      http.Response response =
          await DataProviders().latestCoinDP(start, limit, convert);

      latestCoinData = latestCoinFromJson(response.body);

      if (response.statusCode == 200) {
        print(latestCoinData.data.first.name);
        // final box = Boxes.getUserData();
        // userData.email = emailAddress;
        // box.put('loginData', userData);
        // return userData;
      }
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
    }
    return latestCoinData;
  }
}
