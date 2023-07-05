import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_tracking_app/models/coin_data.dart';
import 'package:crypto_tracking_app/services/repositories.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CoinData> latestCoinData = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    callingApi();
  }

  callingApi() async {
    await Repositories().latestCoinRepo("1", "200", "BDT");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 18, 59),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("cryptoCurrency")
              .orderBy("cmc_rank", descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final coinData = snapshot.data?.docs
                  .map((e) => CoinData.fromJson(e.data()))
                  .toList();
              latestCoinData.clear();
              for (var b in coinData) {
                latestCoinData.add(b);
              }

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Theme(
                  data: ThemeData(
                    primaryColor: const Color.fromARGB(255, 199, 181, 231),
                    cardColor: Color.fromARGB(255, 193, 230, 233),
                    textTheme: const TextTheme(
                      headline6:
                          TextStyle(color: Color.fromRGBO(73, 70, 70, 1)),
                      bodyText2:
                          TextStyle(color: Color.fromARGB(255, 90, 84, 84)),
                      caption:
                          TextStyle(color: Color.fromARGB(255, 71, 69, 69)),
                    ),
                  ),
                  child: PaginatedDataTable(
                    source: TableRow(
                        latestCoinList: latestCoinData.reversed.toList(),
                        refresh: () {
                          setState(() {});
                        }),
                    header: const Text('Crypto Currency'),
                    columns: datacolumn(context),
                    columnSpacing: 100,
                    horizontalMargin: 8,
                    rowsPerPage: 14,
                    sortAscending: false,
                    showCheckboxColumn: false,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const Text("Something Went Wrong!");
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  List<DataColumn> datacolumn(BuildContext context) {
    return <DataColumn>[
      DataColumn(
          label: Text(
        "Rank",
        style: Theme.of(context).textTheme.subtitle2,
      )),
      DataColumn(
          label: Text(
        "Name",
        style: Theme.of(context).textTheme.subtitle2,
      )),
      DataColumn(
        label: Text(
          "Last Updated",
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
      DataColumn(
        label: Text(
          "Price",
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
      DataColumn(
        label: Text(
          "Market Num Pairs",
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
    ];
  }
}

class TableRow extends DataTableSource {
  List<CoinData> latestCoinList;

  Function refresh;

  TableRow({required this.latestCoinList, required this.refresh});

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(SizedBox(
          // width: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text((latestCoinList[index].cmcRank.toString())),
              const SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Text(
                    latestCoinList[index].symbol,
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        )),
        DataCell(Text((latestCoinList[index].name))),
        DataCell(
          latestCoinList[index].lastUpdated != ""
              ? Text(
                  DateFormat('EEEE, MMM d, yyyy, hh:MM').format(
                    DateTime.parse(
                        latestCoinList[index].lastUpdated.toString()),
                  ),
                )
              : Text(""),
        ),
        DataCell(Text(
            "${latestCoinList[index].quote.bdt.price.toStringAsFixed(3)}   BDT")),
        DataCell(Text(latestCoinList[index].numMarketPairs.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  get rowCount => latestCoinList.length;

  @override
  int get selectedRowCount => 0;
}
