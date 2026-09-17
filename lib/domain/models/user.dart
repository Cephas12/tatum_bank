class User {
  final int id;
  final String name;
  final String email;
  final String token;
  final bool isVerified;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    this.isVerified = false,
  });

  factory User.fromJson(
    Map<String, dynamic> json, {
    String? fallbackToken,
  }) {
    final nestedUser = json['user'];
    final user = nestedUser is Map<String, dynamic> ? nestedUser : json;
    final rawId = user['id'] ?? user['userId'];
    final id = rawId is int ? rawId : int.tryParse('$rawId') ?? 0;
    final name = (user['name'] ??
            '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}'.trim())
        .toString();

    return User(
      id: id,
      name: name.isEmpty ? (user['email'] ?? '').toString() : name,
      email: (user['email'] ?? '').toString(),
      token: (json['token'] ??
              json['accessToken'] ??
              user['token'] ??
              user['accessToken'] ??
              fallbackToken ??
              '')
          .toString(),
      isVerified: user['isVerified'] as bool? ??
          user['emailVerified'] as bool? ??
          false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'token': token,
        'isVerified': isVerified,
      };

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts.last[0]).toUpperCase();
  }

  User copyWith({String? name, String? email, bool? isVerified}) => User(
        id: id,
        name: name ?? this.name,
        email: email ?? this.email,
        token: token,
        isVerified: isVerified ?? this.isVerified,
      );
}
