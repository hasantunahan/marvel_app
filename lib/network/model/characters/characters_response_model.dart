import "package:json_annotation/json_annotation.dart";

part "characters_response_model.g.dart";

@JsonSerializable(includeIfNull: false)
class CharacterResponseModel {
  int? id;
  String? name;
  String? description;
  String? modified;
  Thumbnail? thumbnail;
  String? resourceURI;
  Comics? comics;
  Comics? series;
  Comics? stories;
  Comics? events;
  List<Urls>? urls;

  CharacterResponseModel(
      {this.id,
        this.name,
        this.description,
        this.modified,
        this.thumbnail,
        this.resourceURI,
        this.comics,
        this.series,
        this.stories,
        this.events,
        this.urls});

  factory CharacterResponseModel.fromJson(Map<String, dynamic> json) => _$CharacterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterResponseModelToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Thumbnail {
  String? path;
  String? extension;

  Thumbnail({this.path, this.extension});

  factory Thumbnail.fromJson(Map<String, dynamic> json) => _$ThumbnailFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);

}

@JsonSerializable(includeIfNull: false)
class Comics {
  int? available;
  String? collectionURI;
  List<Items>? items;
  int? returned;

  Comics({this.available, this.collectionURI, this.items, this.returned});

  factory Comics.fromJson(Map<String, dynamic> json) => _$ComicsFromJson(json);

  Map<String, dynamic> toJson() => _$ComicsToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Items {
  String? resourceURI;
  String? name;
  String? type;

  Items({this.resourceURI, this.name, this.type});

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Urls {
  String? type;
  String? url;

  Urls({this.type, this.url});

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsToJson(this);

}
