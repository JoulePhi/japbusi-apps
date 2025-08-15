import 'dart:convert';

class RegisterRequest {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final DateTime dob;
  final String city;
  final String address;
  final String company;
  final String workPlace;
  final int federation;
  final int? dpc;
  final String password;
  final String confirmPassword;
  final String? federationName;
  final String? companyCity;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.dob,
    required this.city,
    required this.address,
    required this.company,
    required this.workPlace,
    required this.federation,
    required this.dpc,
    required this.password,
    required this.confirmPassword,
    this.federationName,
    this.companyCity,
  });

  RegisterRequest copyWith({
    String? name,
    String? email,
    String? phone,
    String? gender,
    DateTime? dob,
    String? city,
    String? address,
    String? company,
    String? workPlace,
    int? federation,
    int? dpc,
    String? password,
    String? confirmPassword,
  }) => RegisterRequest(
    name: name ?? this.name,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    gender: gender ?? this.gender,
    dob: dob ?? this.dob,
    city: city ?? this.city,
    address: address ?? this.address,
    company: company ?? this.company,
    workPlace: workPlace ?? this.workPlace,
    federation: federation ?? this.federation,
    dpc: dpc ?? this.dpc,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword,
    federationName: federationName ?? federationName,
    companyCity: companyCity ?? companyCity,
  );

  factory RegisterRequest.fromRawJson(String str) =>
      RegisterRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        city: json["city"],
        address: json["address"],
        company: json["company"],
        workPlace: json["work_place"],
        federation: json["federation"],
        dpc: json["dpc"],
        password: json["password"],
        confirmPassword: json["confirm_password"],
        federationName: json["federation_name"],
        companyCity: json["company_city"],
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "gender": gender,
    "dob":
        "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "city": city,
    "address": address,
    "company": company,
    "work_place": workPlace,
    "federation": federation,
    "dpc": dpc ?? '',
    "password": password,
    "confirm_password": confirmPassword,
    "federation_name": federationName ?? '',
    "company_city": companyCity ?? '',
  };
}
