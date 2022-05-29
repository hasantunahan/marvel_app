import 'package:json_annotation/json_annotation.dart';
part 'comics_response_model.g.dart';

@JsonSerializable(includeIfNull: false)
class ComicResponseModel {
  int? id;
  int? digitalId;
  String? title;
  int? issueNumber;
  String? variantDescription;
  String? description;
  String? modified;
  int? pageCount;
  List<Dates>? dates;
  Thumbnail? thumbnail;

  ComicResponseModel({
    this.id,
    this.digitalId,
    this.title,
    this.issueNumber,
    this.variantDescription,
    this.description,
    this.modified,
    this.pageCount,
    this.dates,
    this.thumbnail,
  });

  factory ComicResponseModel.fromJson(Map<String, dynamic> json) => _$ComicResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ComicResponseModelToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Dates {
  String? type;
  String? date;

  Dates({this.type, this.date});

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

  Map<String, dynamic> toJson() => _$DatesToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Thumbnail {
  String? path;
  String? extension;

  Thumbnail({this.path, this.extension});

  factory Thumbnail.fromJson(Map<String, dynamic> json) => _$ThumbnailFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}
