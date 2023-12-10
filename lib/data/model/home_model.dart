class HomeModel {
  HomeModel({
    this.id,
    this.date,
    this.slug,
    this.type,
    this.link,
    this.protected,
  });

  HomeModel.fromJson(dynamic json) {
    id = json['id'];
    date = json['date'];
    slug = json['slug'];
    type = json['type'];
    link = json['link'];
    protected = json['protected'];
  }
  int? id;
  String? date;
  String? slug;
  String? type;
  String? link;
  bool? protected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date;
    map['slug'] = slug;
    map['type'] = type;
    map['link'] = link;
    map['protected'] = protected;
    return map;
  }
}
