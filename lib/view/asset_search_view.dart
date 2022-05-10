import 'package:assettrackerapp/model/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AssetSearchScreen extends StatefulWidget {
  const AssetSearchScreen({Key? key}) : super(key: key);

  @override
  State<AssetSearchScreen> createState() => _AssetSearchScreenState();
}

class _AssetSearchScreenState extends State<AssetSearchScreen> {
  //final TextEditingController _searchController = TextEditingController();
  final TextEditingController _assetNameController = TextEditingController();
  final TextEditingController _assetLocationController =
      TextEditingController();
  final TextEditingController _assetTypeController = TextEditingController();
  final TextEditingController _assetReportController = TextEditingController();

  final Report _report = Report();

  _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _assetNameController.dispose();
    _assetLocationController.dispose();
    _assetTypeController.dispose();
    _assetReportController.dispose();
    super.dispose();
  }

  /*final _formKey = GlobalKey<FormState>();

  //doc IDs
  //List<String> docIDs = [];

  // get doc IDs
  /*Future getDocId() async {
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
  }*/

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
*/
  CollectionReference ref = FirebaseFirestore.instance.collection('assetData');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Search Asset'),
        ),
        body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  var doc = snapshot.data!.docs[index];
                  return ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_right),
                      onPressed: () {
                        _assetNameController.text = doc['asset name'];
                        _assetLocationController.text = doc['asset location'];
                        _assetTypeController.text = doc['asset type'];

                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView(
                                      children: <Widget>[
                                        _buildTextField(
                                            _assetNameController, 'Asset Name'),
                                        const SizedBox(height: 20),
                                        _buildTextField(
                                            _assetLocationController,
                                            'Asset Location'),
                                        const SizedBox(height: 20),
                                        _buildTextField(
                                            _assetTypeController, 'Asset Name'),
                                        const SizedBox(height: 20),
                                        _buildTextField(_assetReportController,
                                            'Report asset'),
                                        const SizedBox(height: 20),
                                        MaterialButton(
                                          color: const Color(0xFF0069FE),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: const Text('Submit Report'),
                                          onPressed: () async {
                                            _saveReport();
                                            _clearReportTextField();
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                          'Report submitted'),
                                                      MaterialButton(
                                                        color: const Color(
                                                            0xFF0069FE),
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15.0),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const Text('Done'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 5),
                                        MaterialButton(
                                          color: const Color(0xFF0069FE),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Done'),
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                      },
                    ),
                    title: Text(doc['asset name']),
                    subtitle: Text(
                        '${doc['asset location']}, (${doc['asset type']})'),
                  );
                }),
              );
            } else {
              return const Text('');
            }
          },
        ));
  }

  void _saveReport() async {
    _report.assetName = _assetNameController.text.trim();
    _report.assetLocation = _assetLocationController.text.trim();
    _report.assetType = _assetLocationController.text.trim();
    _report.report = _assetReportController.text.trim();
    _report.reportDate = DateTime.now();

    await FirebaseFirestore.instance
        .collection('reports')
        .add(_report.toJson());
  }

  void _clearReportTextField() {
    _assetReportController.clear();
  }
}



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