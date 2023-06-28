import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_tracking_app/models/coin_data.dart';
import 'package:flutter/material.dart';

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
    readData();
    print(latestCoinData.length);
  }

  // callingApi() async {
  //   // Timer.periodic(Duration(minutes: 14), (timer) async {

  //   latestCoinData = await Repositories().latestCoinRepo("1", "200", "BDT");
  //   setState(() {});
  //   print(latestCoinData!.data);
  //   // });
  // }

  //  retrieveData() async {
  //   try {
  //     final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //     // Create a Firestore collection reference
  //     CollectionReference collectionRef =
  //         firestore.collection('cryptoCurrency');

  //     // Retrieve the documents from the collection
  //     QuerySnapshot querySnapshot = await collectionRef.get();

  //     // Loop through the documents and access the data
  //     for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
  //       // Access the document data as a Map
  //       print(documentSnapshot.data());
  //       if (documentSnapshot.exists) {
  //       return  CoinData.fromJson(documentSnapshot.data());
  //       }

  //     }
  //   } catch (e) {
  //     print('Error retrieving data: $e');
  //   }
  // }

  Stream<List<CoinData>> readData() => FirebaseFirestore.instance
          .collection("cryptoCurrency")
          .snapshots()
          .map((event) {
        print(event.docs.first.id);
        return event.docs.map((e) => CoinData.fromJson(e.data())).toList();
      });

// latestCoinData == null
//               ? const Center(child: CircularProgressIndicator())
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("cryptoCurrency")
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final coinData = snapshot.data?.docs
                  .map((e) => CoinData.fromJson(e.data()))
                  .toList();
              for (var b in coinData) {
                latestCoinData.add(b);
              }
              print(latestCoinData.length);

              return
                  // : ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: BouncingScrollPhysics(),
                  //     itemCount: latestCoinData!.data.length,
                  //     itemBuilder: (context, index) {
                  //       return Row(
                  //         children: [
                  //           Text(latestCoinData!.data[index].cmcRank.toString()),
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           CircleAvatar(
                  //             backgroundColor: Colors.amber[100],
                  //             radius: 15,
                  //             child: Text(
                  //               latestCoinData!.data[index].symbol,
                  //               style: const TextStyle(
                  //                   fontSize: 8,
                  //                   fontWeight: FontWeight.w100,
                  //                   color: Colors.black),
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           SizedBox(
                  //             // height: MediaQuery.of(context).size.height / 4,
                  //             child: Text(
                  //               latestCoinData!.data[index].name,
                  //               style: const TextStyle(
                  //                   fontSize: 15, fontWeight: FontWeight.w400),
                  //             ),
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   ),

                  SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: PaginatedDataTable(
                  source:
                      TableRow(latestCoinList: latestCoinData, refresh: () {}),
                  header: const Text('Crypto Currency'),
                  columns: Datacolumn(context),
                  columnSpacing: 100,
                  horizontalMargin: 10,
                  rowsPerPage: 14,
                  showCheckboxColumn: false,
                ),
              );
            } else if (snapshot.hasError) {
              print(snapshot.data);
              return const Text("Something Went Wrong!");
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  List<DataColumn> Datacolumn(BuildContext context) {
    return <DataColumn>[
      DataColumn(
          label: Text(
        "Rank",
        style: Theme.of(context).textTheme.subtitle2,
      )),
      DataColumn(
        label: Text(
          "",
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
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
          "Date Added",
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
        DataCell(Text((latestCoinList[index].cmcRank.toString()))),
        DataCell(CircleAvatar(
          child: Text(latestCoinList[index].symbol),
        )),
        DataCell(Text((latestCoinList[index].name))),
        DataCell(Text(latestCoinList[index].lastUpdated.toString())),
        DataCell(Text(latestCoinList[index].dateAdded.toString())),
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
