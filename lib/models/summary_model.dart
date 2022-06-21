// To parse this JSON data, do
//
//     final summaryModel = summaryModelFromJson(jsonString);

import 'dart:convert';

SummaryModel summaryModelFromJson(String str) =>
    SummaryModel.fromJson(json.decode(str));

String summaryModelToJson(SummaryModel data) => json.encode(data.toJson());

class SummaryModel {
  SummaryModel({
    required this.data,
    required this.lastUpdate,
  });

  final Data data;
  final String lastUpdate;

  factory SummaryModel.fromJson(Map<String, dynamic> json) => SummaryModel(
        data: Data.fromJson(json["data"]),
        lastUpdate: json["last_update"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "last_update": lastUpdate,
      };
}

class Data {
  Data({
    required this.total,
    required this.recoveries,
    required this.deaths,
    required this.activeCases,
    required this.fatalityRate,
    required this.recoveryRate,
  });

  final int total;
  final int recoveries;
  final int deaths;
  final int activeCases;
  final String fatalityRate;
  final String recoveryRate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"],
        recoveries: json["recoveries"],
        deaths: json["deaths"],
        activeCases: json["active_cases"],
        fatalityRate: json["fatality_rate"],
        recoveryRate: json["recovery_rate"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "recoveries": recoveries,
        "deaths": deaths,
        "active_cases": activeCases,
        "fatality_rate": fatalityRate,
        "recovery_rate": recoveryRate,
      };
}
