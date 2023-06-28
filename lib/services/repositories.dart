import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_tracking_app/models/latest_coin_model.dart';
import 'package:crypto_tracking_app/services/data_providers.dart';
import 'package:http/http.dart' as http;

class Repositories {
  Future<LatestCoin> latestCoinRepo(
      String start, String limit, String convert) async {
    LatestCoin latestCoinData;
    Map<String, dynamic> a = {};
    // Timer.periodic(Duration(seconds: 3), (timer) async {
    try {
      http.Response response =
          await DataProviders().latestCoinDP(start, limit, convert);

      a = jsonDecode(response.body);
      latestCoinData = latestCoinFromJson(response.body);

      if (response.statusCode == 200) {
        print(latestCoinData.data.first.name);
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference collectionRef =
            firestore.collection('cryptoCurrency');
        for (var data in a["data"]) {
          await collectionRef.add(data);
        }

        // final docUser = FirebaseFirestore.instance
        //     .collection("cryptoCurrency")
        //     .doc(DateTime.now().toString());

        // docUser.set({
        //   "data": latestCoinData.data,
        // });

        // final box = Boxes.getUserData();
        // userData.email = emailAddress;
        // box.put('loginData', userData);
        // return userData;
      }
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
    }
    // });
    return latestCoinData;
  }
}
