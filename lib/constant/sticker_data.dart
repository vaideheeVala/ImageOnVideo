
import 'dart:convert';

List<Sticker> stickerDataModelFromJson(String str) => List<Sticker>.from(json.decode(str).map((x) => Sticker.fromJson(x)));
String stickerDataToJson(List<Sticker> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Sticker {
  Sticker({
    this.name,
    this.asset,
    this.height,
    this.width,
  });

  String name;
  String asset;
  String height;
  String width;

  factory Sticker.fromJson(Map<String, dynamic> json) => Sticker(
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
