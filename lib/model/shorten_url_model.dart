import 'dart:convert';

ShotenUrlModel shotenUrlModelFromJson(String str) =>
    ShotenUrlModel.fromJson(json.decode(str));

String shotenUrlModelToJson(ShotenUrlModel data) => json.encode(data.toJson());

class ShotenUrlModel {
  String? resultUrl;

  ShotenUrlModel({
    this.resultUrl,
  });

  factory ShotenUrlModel.fromJson(Map<String, dynamic> json) => ShotenUrlModel(
        resultUrl: json["result_url"],
      );

  Map<String, dynamic> toJson() => {
        "result_url": resultUrl,
      };
}
