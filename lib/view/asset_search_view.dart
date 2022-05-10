import 'package:assettrackerapp/services/asset_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AssetSearchScreen extends StatefulWidget {
  const AssetSearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AssetSearchScreen> createState() => _AssetSearchScreenState();
}

class _AssetSearchScreenState extends State<AssetSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //doc IDs
  List<String> docIDs = [];

  // get doc IDs
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('assetData')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }
  /*@override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  /*searchAssetInFirebase() async {
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
  }*/

  Future<void> _initRetrieval() async {
    assetList = service.retrieveAssets();
    retrievedAssetList = await service.retrieveAssets();
  }

  DatabaseService service = DatabaseService();
  Future<List<Asset>> assetList;
  List<Asset> retrievedAssetList;*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Search Asset'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getDocId(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: docIDs.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            title: GetAssetDetails(documentId: docIDs[index]),
                          );
                        }));
                  })),
        ],
      ),
    );

    /*Container(
        child: Column(
          children: [
            TextFormField(
                controller: _searchController,
                decoration:
                    const InputDecoration(prefixIcon: Icon(Icons.search))),
            Expanded(
                child: ListView.builder(
                    itemCount: retrievedAssetList.length,
                    itemBuilder: (context, index) {
                      return AssetCard(retrievedAssetList[index]);
                    })),
          ],
        ),
      ),*/

    // ignore: non_constant_identifier_names
    /* Widget BuildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _assetData.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print(snapshot.data);
            return ListView(
              children: [
                ...snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['assetName'].toString().toLowerCase().contains(
                            _searchController.toString().toLowerCase()))
                    .map((QueryDocumentSnapshot<Object?> data) {
                  final String assetName = data.get('asset name');
                  final String assetLocation = data.get('asset location');

                  return ListTile(
                      title: Text(assetName),
                      subtitle: Text(assetLocation),
                      onTap: () {});
                })
              ],
            );
          }
        });*/
  }
}

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