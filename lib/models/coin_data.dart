// To parse this JSON data, do
//
//     final coinData = coinDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CoinData> coinDataFromJson(String str) =>
    List<CoinData>.from(json.decode(str).map((x) => CoinData.fromJson(x)));

String coinDataToJson(List<CoinData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CoinData {
  final int id;
  final String name;
  final String symbol;
  final String slug;
  final int numMarketPairs;
  final String dateAdded;
  final List<String> tags;
  final double maxSupply;
  final double circulatingSupply;
  final double totalSupply;
  final bool infiniteSupply;
  final dynamic platform;
  final int cmcRank;
  final double selfReportedCirculatingSupply;
  final double selfReportedMarketCap;
  final double tvlRatio;
  final String lastUpdated;
  final Quote quote;

  CoinData({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.numMarketPairs,
    required this.dateAdded,
    required this.tags,
    required this.maxSupply,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.infiniteSupply,
    required this.platform,
    required this.cmcRank,
    required this.selfReportedCirculatingSupply,
    required this.selfReportedMarketCap,
    required this.tvlRatio,
    required this.lastUpdated,
    required this.quote,
  });

  factory CoinData.fromJson(Map<String, dynamic> json) => CoinData(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        symbol: json["symbol"] ?? "",
        slug: json["slug"] ?? "",
        numMarketPairs: json["num_market_pairs"] ?? 0,
        dateAdded: json["date_added"] ?? "",
        tags: List<String>.from(json["tags"] ?? []),
        maxSupply:
            json["max_supply"] != null ? json["max_supply"].toDouble() : 0.0,
        circulatingSupply: json["circulating_supply"] != null
            ? json["circulating_supply"].toDouble()
            : 0.0,
        totalSupply: json["total_supply"] != null
            ? json["total_supply"].toDouble()
            : 0.0,
        infiniteSupply: json["infinite_supply"] ?? false,
        platform: json["platform"] ?? {},
        cmcRank: json["cmc_rank"] ?? 0,
        selfReportedCirculatingSupply:
            json["self_reported_circulating_supply"] != null
                ? json["self_reported_circulating_supply"].toDouble()
                : 0.0,
        selfReportedMarketCap: json["self_reported_market_cap"] != null
            ? json["self_reported_market_cap"].toDouble()
            : 0.0,
        tvlRatio:
            json["tvl_ratio"] != null ? json["tvl_ratio"].toDouble() : 0.0,
        lastUpdated: json["last_updated"] ?? "",
        quote: Quote.fromJson(json["quote"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "slug": slug,
        "num_market_pairs": numMarketPairs,
        "date_added": dateAdded,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "max_supply": maxSupply,
        "circulating_supply": circulatingSupply,
        "total_supply": totalSupply,
        "infinite_supply": infiniteSupply,
        "platform": platform,
        "cmc_rank": cmcRank,
        "self_reported_circulating_supply": selfReportedCirculatingSupply,
        "self_reported_market_cap": selfReportedMarketCap,
        "tvl_ratio": tvlRatio,
        "last_updated": lastUpdated,
        "quote": quote.toJson(),
      };
}

class Quote {
  final Bdt bdt;

  Quote({
    required this.bdt,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        bdt: Bdt.fromJson(json["BDT"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "BDT": bdt.toJson(),
      };
}

class Bdt {
  final double price;
  final double volume24H;
  final double volumeChange24H;
  final double percentChange1H;
  final double percentChange24H;
  final double percentChange7D;
  final double percentChange30D;
  final double percentChange60D;
  final double percentChange90D;
  final double marketCap;
  final double marketCapDominance;
  final double fullyDilutedMarketCap;
  final double tvl;
  final String lastUpdated;

  Bdt({
    required this.price,
    required this.volume24H,
    required this.volumeChange24H,
    required this.percentChange1H,
    required this.percentChange24H,
    required this.percentChange7D,
    required this.percentChange30D,
    required this.percentChange60D,
    required this.percentChange90D,
    required this.marketCap,
    required this.marketCapDominance,
    required this.fullyDilutedMarketCap,
    required this.tvl,
    required this.lastUpdated,
  });

  factory Bdt.fromJson(Map<String, dynamic> json) => Bdt(
        price: json["price"] != null ? json["price"].toDouble() : 0.0,
        volume24H:
            json["volume_24h"] != null ? json["volume_24h"].toDouble() : 0.0,
        volumeChange24H: json["volume_change_24h"] != null
            ? json["volume_change_24h"].toDouble()
            : 0.0,
        percentChange1H: json["percent_change_1h"] != null
            ? json["percent_change_1h"].toDouble()
            : 0.0,
        percentChange24H: json["percent_change_24h"] != null
            ? json["percent_change_24h"].toDouble()
            : 0.0,
        percentChange7D: json["percent_change_7d"] != null
            ? json["percent_change_7d"].toDouble()
            : 0.0,
        percentChange30D: json["percent_change_30d"] != null
            ? json["percent_change_30d"].toDouble()
            : 0.0,
        percentChange60D: json["percent_change_60d"] != null
            ? json["percent_change_60d"].toDouble()
            : 0.0,
        percentChange90D: json["percent_change_90d"] != null
            ? json["percent_change_90d"].toDouble()
            : 0.0,
        marketCap:
            json["market_cap"] != null ? json["market_cap"].toDouble() : 0.0,
        marketCapDominance: json["market_cap_dominance"] != null
            ? json["market_cap_dominance"].toDouble()
            : 0.0,
        fullyDilutedMarketCap: json["fully_diluted_market_cap"] != null
            ? json["fully_diluted_market_cap"].toDouble()
            : 0.0,
        tvl: json["tvl"] != null ? json["tvl"].toDouble() : 0.0,
        lastUpdated: json["last_updated"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "volume_24h": volume24H,
        "volume_change_24h": volumeChange24H,
        "percent_change_1h": percentChange1H,
        "percent_change_24h": percentChange24H,
        "percent_change_7d": percentChange7D,
        "percent_change_30d": percentChange30D,
        "percent_change_60d": percentChange60D,
        "percent_change_90d": percentChange90D,
        "market_cap": marketCap,
        "market_cap_dominance": marketCapDominance,
        "fully_diluted_market_cap": fullyDilutedMarketCap,
        "tvl": tvl,
        "last_updated": lastUpdated,
      };
}
