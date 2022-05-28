import "package:json_annotation/json_annotation.dart";

part 'response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseModel<T> {
  int? code;
  T? data;
  String? status;

  ResponseModel({
    this.code,
    this.data,
    this.status,
  });

  factory ResponseModel.fromJson(dynamic json, T Function(Object? json) fromJsonT) =>
      _$ResponseModelFromJson(json as Map<String, dynamic>, (json) {
        return fromJsonT(json);
      });
}
