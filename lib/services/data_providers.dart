import 'package:crypto_tracking_app/services/api_call.dart';
import 'package:crypto_tracking_app/utils/constant.dart';
import 'package:http/http.dart' as http;

class DataProviders {
  Future<http.Response> latestCoinDP(
      String start, String limit, String convert) async {
    final params = "start=$start&limit=$limit&convert=$convert";

    http.Response response = await http.get(
      Uri.parse(ApiCall.cryptoApi(params)),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'X-CMC_PRO_API_KEY': apiKey,
      },
    );
    return response;
  }
}
