import 'dart:async';

import 'package:crypto_tracking_app/models/latest_coin_model.dart';
import 'package:crypto_tracking_app/services/repositories.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LatestCoin? latestCoinData;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    callingApi();
    super.initState();
  }

  callingApi() async {
    Timer.periodic(Duration(minutes: 14), (timer) async {
      latestCoinData = await Repositories().latestCoinRepo("1", "5000", "BDT");
      setState(() {});
      print(latestCoinData!.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: latestCoinData == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: latestCoinData!.data.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text(latestCoinData!.data[index].cmcRank.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.amber[100],
                      radius: 15,
                      child: Text(
                        latestCoinData!.data[index].symbol,
                        style: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w100,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      // height: MediaQuery.of(context).size.height / 4,
                      child: Text(
                        latestCoinData!.data[index].name,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                );
              }),
    );
  }
}

//   List<DataColumn> Datacolumn(BuildContext context) {
//     return <DataColumn>[
//       DataColumn(
//           label: Text(
//         "POI ID",
//         style: Theme.of(context).textTheme.subtitle2,
//       )),
//       DataColumn(
//         label: Text(
//           "POI Type",
//           style: Theme.of(context).textTheme.subtitle2,
//         ),
//       ),
//       DataColumn(
//         label: Text(
//           "Union",
//           style: Theme.of(context).textTheme.subtitle2,
//         ),
//       ),
//       DataColumn(
//         label: Text(
//           "Thana",
//           style: Theme.of(context).textTheme.subtitle2,
//         ),
//       ),
//       DataColumn(
//         label: Text(
//           "District",
//           style: Theme.of(context).textTheme.subtitle2,
//         ),
//       ),
//     ];
//   }
// }

// class TableRow extends DataTableSource {
//   LatestCoin? latestCoinList;

//   Function refresh;

//   TableRow({required this.latestCoinList, required this.refresh});

//   @override
//   DataRow? getRow(int index) {
//     return DataRow.byIndex(
//       index: index,
//       cells: [
//         DataCell(Center(child: Text((latestCoinList!.data[index].name)))),
//         DataCell(Center(child: Text(latestCoinList!.data[index].symbol))),
//         DataCell(Center(
//             child: Text(latestCoinList!.data[index].lastUpdated.toString()))),
//         DataCell(Center(
//             child: Text(latestCoinList!.data[index].dateAdded.toString()))),
//         DataCell(Center(
//             child:
//                 Text(latestCoinList!.data[index].numMarketPairs.toString()))),
//       ],
//     );
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   get rowCount => latestCoinList!.data.length;

//   @override
//   int get selectedRowCount => 0;
// }
