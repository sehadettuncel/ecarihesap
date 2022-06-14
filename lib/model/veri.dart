class Data{
  String access_token;
  String email;
  Data({this.access_token, this.email});

  factory Data.fromJson(Map <String, dynamic> json){
    return Data(
      access_token: json['acces_token'],
      email: json['email'],
    );
  }
}