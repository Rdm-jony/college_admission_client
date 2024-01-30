class UserModel {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? university;
  String? address;
  String? number;
  String? role;
  String? image;

  UserModel(
      {this.sId,
      this.name,
      this.email,
      this.password,
      this.university,
      this.address,
      this.number,
      this.role,
      this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    university = json['university'];
    address = json['address'];
    number = json['number'];
    role = json['role'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['university'] = this.university;
    data['address'] = this.address;
    data['number'] = this.number;
    data['role'] = this.role;
    data['image'] = this.image;
    return data;
  }
}