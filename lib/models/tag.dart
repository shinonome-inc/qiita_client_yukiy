class Tag {
  int? followersCount;
  String? iconUrl;
  String? id;
  int? itemsCount;

  Tag({this.followersCount, this.iconUrl, this.id, this.itemsCount});

  Tag.fromJson(Map<String, dynamic> json) {
    followersCount = json['followers_count'];
    iconUrl = json['icon_url'];
    id = json['id'];
    itemsCount = json['items_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['followers_count'] = followersCount;
    data['icon_url'] = iconUrl;
    data['id'] = id;
    data['items_count'] = itemsCount;
    return data;
  }
}
