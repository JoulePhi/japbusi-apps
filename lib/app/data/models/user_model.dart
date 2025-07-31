class User {
  final int id;
  final int federationId;
  final int roleId;
  final int? level;
  final int? subLevel;
  final String name;
  final String email;
  final String? federationName;
  final String? levelName;
  final String? subLevelName;
  final String companyName;
  final String roleName;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.companyName,
    required this.roleId,
    required this.roleName,
    this.federationId = 0,
    this.level,
    this.federationName,
    this.levelName,
    this.subLevel,
    this.subLevelName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['user_id'],
    name: json['name'],
    email: json['email'],
    federationId: json['id_federation'] ?? 0,
    federationName: json['federation_name'],
    level: json['level'] ?? 0,
    levelName: json['level_name'],
    subLevel: json['sublevel'] ?? 0,
    subLevelName: json['sublevel_name'],
    companyName: json['company_name'] ?? '',
    roleId: json['role_id'] ?? 0,
    roleName: json['role_name'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'user_id': id,
    'name': name,
    'email': email,
    'id_federation': federationId,
    'federation_name': federationName,
    'level': level,
    'level_name': levelName,
    'sublevel': subLevel,
    'sublevel_name': subLevelName,
    'company_name': companyName,
    'role_id': roleId,
    'role_name': roleName,
  };
}
