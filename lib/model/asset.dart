import 'package:cloud_firestore/cloud_firestore.dart';

class Asset {
  final String assetId;
  final String assetName;
  final String assetType;
  final String assetLocation;

  Asset(
      {required this.assetId,
      required this.assetName,
      required this.assetType,
      required this.assetLocation});

  Map<String, dynamic> toMap() {
    return {
      'asset id': assetId,
      'asset name': assetName,
      'asset type': assetType,
      'asset location': assetLocation
    };
  }

  Asset.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : assetId = doc.data()?['asset id'],
        assetName = doc.data()?['asset name'],
        assetType = doc.data()?['asset type'],
        assetLocation = doc.data()?['asset location'];

  /*Asset.fromSnapshot(snapshot)
      : assetName = snapshot.data()['asset name'],
        assetType = snapshot.data()['asset type'],
        assetLocation = snapshot.data()['asset location'];*/
}

class AssetDataDisplay {
  final String assetId;
  final String assetName;
  final String assetType;
  final String assetLocation;

  AssetDataDisplay(
      {required this.assetId,
      required this.assetName,
      required this.assetType,
      required this.assetLocation});
}
