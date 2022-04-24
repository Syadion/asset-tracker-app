import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AssetSearchScreen extends StatefulWidget {
  const AssetSearchScreen({Key? key}) : super(key: key);

  @override
  State<AssetSearchScreen> createState() => _AssetSearchScreenState();
}

class _AssetSearchScreenState extends State<AssetSearchScreen> {
  final TextEditingController _searchBar = TextEditingController();

  final CollectionReference _assetData =
      FirebaseFirestore.instance.collection('assetData');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Search Asset'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchBar,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: "Enter Asset Name",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _assetData.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element['assetName']
                        .toString()
                        .toLowerCase()
                        .contains(_searchBar.text))
                .isEmpty) {
              return const Center(
                child: Text('No data'),
              );
            } else {
              return ListView(
                children: [
                  ...snapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) =>
                          element['assetName']
                              .toString()
                              .toLowerCase()
                              .contains(_searchBar.text))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    final String assetName = data.get('assetName');

                    return ListTile(
                      title: Text(assetName),
                      leading: const CircleAvatar(backgroundColor: Colors.blue),
                    );
                  })
                ],
              );
            }
          }
        });
  }
}
