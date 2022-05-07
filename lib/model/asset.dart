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
}
