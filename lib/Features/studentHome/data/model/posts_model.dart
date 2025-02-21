class PostsModel {
  int? postId;
  int? postPublisher;
  int? postUserCode;
  String? postDate;
  int? postType;
  String? postText;
  String? postMedia;
  int? department;
  int? band;
  String? mediaName;
  String? publisherName;
  String? publisherImage;

  PostsModel({
    this.postId,
    this.postPublisher,
    this.postUserCode,
    this.postDate,
    this.postType,
    this.postText,
    this.postMedia,
    this.department,
    this.band,
    this.mediaName,
    this.publisherName,
    this.publisherImage,
  });

  PostsModel.fromJson(Map<String, dynamic> json) {
    postId = _parseToInt(json['postId']);
    postPublisher = _parseToInt(json['postPublisher']);
    postUserCode = _parseToInt(json['postUserCode']);
    postDate = json['postDate'];
    postType = _parseToInt(json['postType']);
    postText = json['postText'];
    postMedia = json['postMedia'];
    department = _parseToInt(json['department']);
    band = _parseToInt(json['band']);
    mediaName = json['media_name'];
    publisherName = json['publisherName'];
    publisherImage = json['publisherImage'];
  }

  // Helper method to safely parse int values
  int? _parseToInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value);
    }
    return null; // Return null if value is neither int nor a valid String
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['postPublisher'] = postPublisher;
    data['postUserCode'] = postUserCode;
    data['postDate'] = postDate;
    data['postType'] = postType;
    data['postText'] = postText;
    data['postMedia'] = postMedia;
    data['department'] = department;
    data['band'] = band;
    data['media_name'] = mediaName;
    data['publisherName'] = publisherName;
    data['publisherImage'] = publisherImage;
    return data;
  }
}
