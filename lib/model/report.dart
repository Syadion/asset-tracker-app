class Report {
  String? assetName;
  String? assetType;
  String? assetLocation;
  String? report;
  DateTime? reportDate;

  Report();

  Map<String, dynamic> toJson() => {
        'asset name': assetName,
        'asset locaiton': assetLocation,
        'asset type': assetType,
        'report': report,
        'reportDate': reportDate
      };
}
