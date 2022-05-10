import 'package:assettrackerapp/model/asset.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addAsset(Asset assetData) async {
    await _db.collection('assetData').add(assetData.toMap());
  }

  updateAsset(Asset assetData) async {
    await _db
        .collection('assetData')
        .doc(assetData.assetName)
        .update(assetData.toMap());
  }

  Future<void> deleteAsset(String documentId) async {
    await _db.collection('assetData').doc(documentId).delete();
  }

  Future<List<Asset>> retrieveAssets() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('assetData').get();
    return snapshot.docs
        .map((docSnapshot) => Asset.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}

class GetAssetDetails extends StatelessWidget {
  final String documentId;

  const GetAssetDetails({Key? key, required this.documentId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference assets =
        FirebaseFirestore.instance.collection('assetData');

    return FutureBuilder<DocumentSnapshot>(
      future: assets.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return ListTile(
            title: Text('${data['asset name']}'),
            subtitle: Text('${data['asset location']} (${data['asset type']})'),
          );
        }
        return const Text('loading...');
      }),
    );
  }
}
