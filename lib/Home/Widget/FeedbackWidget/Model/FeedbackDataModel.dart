class FeedbackDataModel {
  String? sId;
  String? collegeName;
  String? id;
  int? rating;
  String? feedback;
  String? date;
  String? image;
  String? name;

  FeedbackDataModel(
      {this.sId,
      this.collegeName,
      this.id,
      this.rating,
      this.feedback,
      this.date,
      this.image,
      this.name});

  FeedbackDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    collegeName = json['collegeName'];
    id = json['id'];
    rating = json['rating'];
    feedback = json['feedback'];
    date = json['date'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['collegeName'] = this.collegeName;
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['feedback'] = this.feedback;
    data['date'] = this.date;
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}
