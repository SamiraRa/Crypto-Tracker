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

    try {
      http.Response response =
          await DataProviders().latestCoinDP(start, limit, convert);

      a = jsonDecode(response.body);
      latestCoinData = latestCoinFromJson(response.body);

      if (response.statusCode == 200) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference collectionRef =
            firestore.collection('cryptoCurrency');
        List datum = a["data"];

        for (var data in datum) {
          final document = collectionRef.doc(data['id'].toString());
          final documentSnapshot = await document.get();

          if (documentSnapshot.exists) {
            await document.update(data);
          } else {
            await document.set(data);
          }
        }
      }
    } on Exception catch (e) {
      print(e);
      throw Exception(e);
    }

    return latestCoinData;
  }
}
