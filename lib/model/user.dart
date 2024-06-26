import 'dart:convert';
import 'profile.dart';

class User {
  int id;
  String username;
  String role;
  Profile profile;

  User({
    required this.id,
    required this.username,
    required this.role,
    required this.profile,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    role: json["role"],
    profile: Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "role": role,
    "profile": profile.toJson(),
  };
}
