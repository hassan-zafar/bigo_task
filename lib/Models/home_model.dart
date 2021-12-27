// To parse this JSON data, do
//
//     final houseData = houseDataFromJson(jsonString?);

import 'dart:convert';

List<HouseData> houseDataFromJson(String? str) =>
    List<HouseData>.from(json.decode(str!).map((x) => HouseData.fromJson(x)));

String? houseDataToJson(List<HouseData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HouseData {
  HouseData({
    this.id,
    this.location,
    this.beds,
    this.baths,
    this.price,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.img,
  });

  int? id;
  String? location;
  String? beds;
  String? baths;
  String? price;
  DateTime? publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Img? img;

  factory HouseData.fromJson(Map<String?, dynamic> json) => HouseData(
        id: json["id"],
        location: json["location"],
        beds: json["beds"],
        baths: json["baths"],
        price: json["price"],
        publishedAt: DateTime?.parse(json["published_at"]),
        createdAt: DateTime?.parse(json["created_at"]),
        updatedAt: DateTime?.parse(json["updated_at"]),
        img: json["img"] == null ? null : Img.fromJson(json["img"]),
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "location": location,
        "beds": beds,
        "baths": baths,
        "price": price,
        "published_at": publishedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "img": img == null ? null : img!.toJson(),
      };
}

class Img {
  Img({
    this.id,
    this.name,
    this.alternativeText,
    this.caption,
    this.width,
    this.height,
    this.formats,
    this.hash,
    this.ext,
    this.mime,
    this.size,
    this.url,
    this.previewUrl,
    this.provider,
    this.providerMetadata,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? alternativeText;
  String? caption;
  int? width;
  int? height;
  Formats? formats;
  String? hash;
  String? ext;
  String? mime;
  double? size;
  String? url;
  dynamic previewUrl;
  String? provider;
  dynamic providerMetadata;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Img.fromJson(Map<String?, dynamic> json) => Img(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: Formats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        size: json["size"],
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: json["provider"],
        providerMetadata: json["provider_metadata"],
        createdAt: DateTime?.parse(json["created_at"]),
        updatedAt: DateTime?.parse(json["updated_at"]),
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        "formats": formats!.toJson(),
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Formats {
  Formats({
    this.small,
    this.medium,
    this.thumbnail,
  });

  Thumbnail? small;
  Thumbnail? medium;
  Thumbnail? thumbnail;

  factory Formats.fromJson(Map<String?, dynamic> json) => Formats(
        small: json["small"] == null ? null : Thumbnail.fromJson(json["small"]),
        medium:
            json["medium"] == null ? null : Thumbnail.fromJson(json["medium"]),
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
      );

  Map<String?, dynamic> toJson() => {
        "small": small == null ? null : small!.toJson(),
        "medium": medium == null ? null : medium!.toJson(),
        "thumbnail": thumbnail!.toJson(),
      };
}

class Thumbnail {
  Thumbnail({
    this.ext,
    this.url,
    this.hash,
    this.mime,
    this.name,
    this.path,
    this.size,
    this.width,
    this.height,
  });

  String? ext;
  String? url;
  String? hash;
  String? mime;
  String? name;
  dynamic path;
  double? size;
  int? width;
  int? height;

  factory Thumbnail.fromJson(Map<String?, dynamic> json) => Thumbnail(
        ext: json["ext"],
        url: json["url"],
        hash: json["hash"],
        mime: json["mime"],
        name: json["name"],
        path: json["path"],
        size: json["size"],
        width: json["width"],
        height: json["height"],
      );

  Map<String?, dynamic> toJson() => {
        "ext": ext,
        "url": url,
        "hash": hash,
        "mime": mime,
        "name": name,
        "path": path,
        "size": size,
        "width": width,
        "height": height,
      };
}
