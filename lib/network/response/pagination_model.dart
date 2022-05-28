import "package:json_annotation/json_annotation.dart";

part 'pagination_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationModel<T> {
  int? offset;
  int? limit;
  int? total;
  int? count;
  List<T>? results;

  PaginationModel({this.offset, this.results, this.limit, this.count, this.total});

  factory PaginationModel.fromJson(dynamic json, T Function(Object? json) fromJsonT) =>
      _$PaginationModelFromJson(json as Map<String, dynamic>, (json) {
        return fromJsonT(json);
      });
}
