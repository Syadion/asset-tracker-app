class Report {
  String? report;
  DateTime? reportDate;

  Report();

  Map<String, dynamic> toJson() =>
      {'report': report, 'report date': reportDate};
}
