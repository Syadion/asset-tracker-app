class Asset {
  String? assetId;
  String? assetName;
  String? assetType;
  String? assetLocation;

  Asset();

  Map<String, dynamic> toJson() => {
        'asset id': assetId,
        'asset name': assetName,
        'asset type': assetType,
        'asset location': assetLocation
      };

  Asset.fromSnapshot(snapshot)
      : assetId = snapshot.data()['asset id'],
        assetName = snapshot.data()['asset name'],
        assetType = snapshot.data()['asset type'],
        assetLocation = snapshot.data()['asset location'];
}
