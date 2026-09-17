// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  final bool success;
  final String message;
  final Data data;
  final dynamic errors;
  final dynamic meta;

  Welcome({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.meta,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    errors: json["errors"],
    meta: json["meta"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
    "errors": errors,
    "meta": meta,
  };
}

class Data {
  final String accessToken;
  final int expiresIn;
  final User user;

  Data({
    required this.accessToken,
    required this.expiresIn,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["accessToken"],
    expiresIn: json["expiresIn"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "expiresIn": expiresIn,
    "user": user.toJson(),
  };
}

class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final dynamic department;
  final dynamic profileImageUrl;
  final dynamic staffId;
  final String role;
  final dynamic registrationOtp;
  final bool isActive;
  final String createdAt;
  final DateTime lastLoginAt;
  final List<dynamic> accounts;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.department,
    required this.profileImageUrl,
    required this.staffId,
    required this.role,
    required this.registrationOtp,
    required this.isActive,
    required this.createdAt,
    required this.lastLoginAt,
    required this.accounts,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phone: json["phone"],
    department: json["department"],
    profileImageUrl: json["profileImageUrl"],
    staffId: json["staffId"],
    role: json["role"],
    registrationOtp: json["registrationOtp"],
    isActive: json["isActive"],
    createdAt: json["createdAt"],
    lastLoginAt: DateTime.parse(json["lastLoginAt"]),
    accounts: List<dynamic>.from(json["accounts"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "department": department,
    "profileImageUrl": profileImageUrl,
    "staffId": staffId,
    "role": role,
    "registrationOtp": registrationOtp,
    "isActive": isActive,
    "createdAt": createdAt,
    "lastLoginAt": lastLoginAt.toIso8601String(),
    "accounts": List<dynamic>.from(accounts.map((x) => x)),
  };
}