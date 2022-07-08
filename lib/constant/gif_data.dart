
import 'dart:convert';

List<Gif> gifDataModelFromJson(String str) => List<Gif>.from(json.decode(str).map((x) => Gif.fromJson(x)));
String gifDataToJson(List<Gif> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Gif {
  Gif({
    this.name,
    this.asset,
    this.height,
    this.width,
  });

  String name;
  String asset;
  String height;
  String width;

  factory Gif.fromJson(Map<String, dynamic> json) => Gif(
    name: json["name"],
    asset: json["asset"],
    height: json["height"],
    width: json["height"],

  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "asset": asset,
    "height":height,
    "width":width,
  };
}
