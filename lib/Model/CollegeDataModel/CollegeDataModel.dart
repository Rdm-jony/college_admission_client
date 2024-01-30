class CollegeDataNodel {
  String? sId;
  String? collegeName;
  List<String>? event;
  String? description;
  String? image;
  String? logo;
  AdmissionDate? admissionDate;
  List<String>? departments;
  String? admissonNotice;
  String? location;
  bool? top;

  CollegeDataNodel(
      {this.sId,
      this.collegeName,
      this.event,
      this.description,
      this.image,
      this.logo,
      this.admissionDate,
      this.departments,
      this.admissonNotice,
      this.location,
      this.top});

  CollegeDataNodel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    collegeName = json['collegeName'];
    event = json['event'].cast<String>();
    description = json['description'];
    image = json['image'];
    logo = json['logo'];
    admissionDate = json['admissionDate'] != null
        ? new AdmissionDate.fromJson(json['admissionDate'])
        : null;
    departments = json['departments'].cast<String>();
    admissonNotice = json['admissonNotice'];
    location = json['location'];
    top = json['top'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['collegeName'] = this.collegeName;
    data['event'] = this.event;
    data['description'] = this.description;
    data['image'] = this.image;
    data['logo'] = this.logo;
    if (this.admissionDate != null) {
      data['admissionDate'] = this.admissionDate!.toJson();
    }
    data['departments'] = this.departments;
    data['admissonNotice'] = this.admissonNotice;
    data['location'] = this.location;
    data['top'] = this.top;
    return data;
  }
}

class AdmissionDate {
  String? start;
  String? end;

  AdmissionDate({this.start, this.end});

  AdmissionDate.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}
