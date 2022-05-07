import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AssetSearchScreen extends StatefulWidget {
  const AssetSearchScreen({Key? key}) : super(key: key);

  @override
  State<AssetSearchScreen> createState() => _AssetSearchScreenState();
}

class _AssetSearchScreenState extends State<AssetSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Map? map;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    print(_searchController.text);
  }
/*
  List<Object> _assetList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAssetList();
  }
*/
  /*final CollectionReference _assetData =
      FirebaseFirestore.instance.collection('assetData');*/

  searchAssetInFirebase() async {
    if (_searchController.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('assetData')
          .where('asset name', isEqualTo: _searchController.text)
          .get()
          .then((value) => {
                for (var i in value.docs)
                  {
                    setState(() {
                      map = i.data();
                      print(map);
                    })
                  }
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Search Asset'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
                controller: _searchController,
                decoration:
                    const InputDecoration(prefixIcon: Icon(Icons.search))),
            /*Expanded(
              child: ListView.builder(
                  itemCount: _assetList.length,
                  itemBuilder: (context, index) {
                    return AssetCard(_assetList[index] as Asset);
                  }),
            ),*/
            ElevatedButton(
                onPressed: () {
                  searchAssetInFirebase();
                },
                child: const Text('search')),
          ],
        ),
      ),
    );
  }
/*
  Future getAssetList() async {
    var data = await FirebaseFirestore.instance.collection('assetData').get();

    setState(() {
      _assetList = List.from(data.docs.map((doc) => Asset.fromSnapshot(doc)));
    });
  }
*/
  /*
  Future getAssetList() async {
    var data = await FirebaseFirestore.instance
        .collection('assetData')
        .doc('asset_name');
  }*/

  /*Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _assetData.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            print(snapshot.data);
            return ListView(
              children: [
                ...snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['asset_name']
                            .toString()
                            .toLowerCase()
                            .contains(_searchBar.toString().toLowerCase()))
                    .map((QueryDocumentSnapshot<Object?> data) {
                  final String assetName = data['asset_name'];
                  final String assetLocation = data['asset_location'];

                  return ListTile(
                    title: Text(assetName),
                    subtitle: Text(assetLocation),
                  );
                })
              ],
            );*/
  /*if (snapshot.data!.docs
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
          }
        });
  }*/
}
