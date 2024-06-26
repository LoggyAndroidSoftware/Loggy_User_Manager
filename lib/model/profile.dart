import 'dart:convert';

class Profile {
  int id;
  String firstname;
  String lastname;
  String email;
  String genre;
  String birthdate;
  String address;

  Profile({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.genre,
    required this.birthdate,
    required this.address,
  });

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    genre: json["genre"],
    birthdate: json["birthdate"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "genre": genre,
    "birthdate": birthdate,
    "address": address,
  };
}