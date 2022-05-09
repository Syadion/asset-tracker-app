import 'package:assettrackerapp/model/asset.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        await _db.collection("assetData").get();
    return snapshot.docs
        .map((docSnapshot) => Asset.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
/*class AssetService {
  FirebaseFirestore? _instance;

  List<Asset> _assets = [];
  List<Asset> getAssets() {
    return _assets;
  }

  Future<void> getAssetsCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;

    Future<QuerySnapshot<Map<String, dynamic>>> assets = _instance!.collection('assetData').get();
  }
}*/
}
